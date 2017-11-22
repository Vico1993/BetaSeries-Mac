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
        var params:[String:String] = [
            "login": username,
            "password": password.md5
        ]
        MakeRequestWith(url: url, requestMethod: "POST", params:params)
    }
    
    func MakeRequestWith( url:String, requestMethod:String, params:[String:String] ) {
        
        var paramString: String = ""
        params.forEach { (key:String, val:String) in
            if ( paramString != "" ) {
                paramString += "&"
            }
            paramString += "\(key)=\(val)"
        }
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        request.httpMethod = requestMethod
        request.httpBody = paramString.data(using: .utf8)
//        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type" )
        request.addValue(APIKey, forHTTPHeaderField: "X-BetaSeries-Key")
        
        print( request.debugHttpBody() )
        
        let requestAPI = URLSession.shared.dataTask(with: request as URLRequest) {data, response, error in
            if (error != nil) {
                // If error, show some details..
                print(error!.localizedDescription)
            }
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {
                // If HttpStatusCode != 200 -> Showing some details to debug
                print("StatusCode := \(httpStatus.statusCode)")
                print("Details := \(String(describing: response))")
            }
            
            let responseAPI = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("return of API :")
            print( responseAPI! )
            
//            if error == nil {
//                // Ce que vous voulez faire.
//            }
        }
        
        requestAPI.resume()
    }
    
    mutating func GetListSeries( ) {
        print("GetListSeries")
        print(token)
        
        token = "TATA"
        
        print("test2")
        print(token)
    }
    
    func GetEpisodesOfSerie( ) {
        
    }
    
}
