//
//  BetaSeries.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 22/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

// TODO :
// Gestion des erreurs

import Foundation
import CoreData

struct BetaSeriesClient {
    
    var APIKey:String
    var token:String = ""
    let base_url:String = "https://api.betaseries.com/"
    
    init( username:String, password:String, ApiKey:String ) {
        // Set ApiKey from the user
        APIKey = ApiKey
        
        let url = base_url + "members/auth"
        let params:[String:String] = [
            "login": username,
            "password": password.md5
        ]
        if let ret = MakeRequestWith(url: url, requestMethod: "POST", params:params) {
            token = ret[ "token" ] as? String ?? ""
        }
    }
    
    func MakeRequestWith( url:String, requestMethod:String, params:[String:String] ) -> [String : AnyObject]? {
        // Verification de l'url
        guard let url = URL(string: url) else {
            print("Error! Invalid URL!") //Do something else
            return nil
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        var request = URLRequest(url: url)
        request.httpMethod = requestMethod
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)

        request.addValue("application/json", forHTTPHeaderField:"Content-Type" )
        request.addValue(APIKey, forHTTPHeaderField: "X-BetaSeries-Key")
        
        var data: Data? = nil
        URLSession.shared.dataTask(with: request) { (responseData, _, _) -> Void in
            data = responseData
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        let reply = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
        if let dataJson = convertStringToDictionary(json: reply) {
            return dataJson
        }
        
        return nil
    }
    
    func GetListSeries( ) {
        print("GetListSeries")
        
        let url = base_url + "episodes/list"
        let params:[String:String] = [
            "token" : token
        ]
        var dict:[Show] = []
        
        if let ret = MakeRequestWith(url: url, requestMethod: "GET", params:params) {
            let shows = ret["shows"] as? [[String: Any]] ?? []
            for show in shows {
                let id                  = show["id"] as! Int
                let title               = show["title"] as! String
                var unseen:[Episode]    = []
                
                let showsUnseen = show["unseen"] as? [[String: Any]] ?? []
                for showsEpisode in showsUnseen {
                    unseen.append(
                        Episode(
                            id          : showsEpisode["id"] as! Int,
                            title       : showsEpisode["title"] as! String,
                            saison      : showsEpisode["season"] as! Int,
                            nb          : showsEpisode["episode"] as! Int,
                            description : showsEpisode["description"] as! String,
                            special     : showsEpisode["special"] as! Int,
                            link        : showsEpisode["resource_url"] as! String,
                            date        : showsEpisode["date"] as! String
                        )
                    )
                }
                
                dict.append( Show(id: id, title: title, episodesunseen: unseen) )
            }
        }
        
        dict.forEach { (Show) in
            print( Show.Title )
        }
        
    }
    
    // A voir..
    func GetEpisodesOfSerie( id:Int ) {
        
    }
}
