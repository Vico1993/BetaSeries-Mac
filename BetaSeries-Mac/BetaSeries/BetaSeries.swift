//
//  BetaSeries.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 22/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Foundation

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
    
    mutating func GetListSeries( ) {
        print("GetListSeries")
        
    }
    
    func GetEpisodesOfSerie( ) {
        
    }
    
}
