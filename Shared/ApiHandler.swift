//
//  ApiHandler.swift
//  IsTodayMeatballsDay
//
//  Created by Simon Kärrman on 2019-04-12.
//  Copyright © 2019 Simon Kärrman. All rights reserved.
//

import Foundation


class ApiHandler {
    private let apiURL = "https://istodaymeatballsday.com/api"
    
    private struct Response: Decodable {
        let msg: String
        let code: Int
    }

    public func getStatusCode(handler: @escaping ((Int) -> Void)) {
        guard let url = URL(string: apiURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let res = try JSONDecoder().decode(Response.self, from: data)
                print(res)
                handler(res.code)
            }catch let error {
                print("JSON error:", error)
            }
            
        }.resume()
        
        
    }
 
}
