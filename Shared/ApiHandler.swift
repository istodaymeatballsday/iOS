//
//  ApiHandler.swift
//  IsTodayMeatballsDay
//
//  Created by Simon Kärrman on 2019-04-12.
//  Copyright © 2019 Simon Kärrman. All rights reserved.
//

import Foundation


class ApiHandler {
    private let apiURL = "https://api.istodaymeatballsday.com"
    
    private struct Response: Decodable {
        let msg: String
        let code: Int
    }

    public func getStatus(handler: @escaping ((String) -> Void)) {
        guard let url = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                handler(res.msg)
            }catch let error {
                print("JSON error:", error)
            }
            
        }.resume()
        
        
    }
 
}
