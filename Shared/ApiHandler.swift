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
    
    public func getStatus(handler: @escaping ((Response) -> Void)) {
        let day = Calendar.current.component(.day, from: Date())
        let (cachedResponse, cachedDay) = loadResponse()
        if cachedResponse != nil && day == cachedDay {
            handler(cachedResponse!)
        } else {
        
            guard let url = URL(string: apiURL) else { return }
        
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
            
                do {
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    self.saveResponse(response: res, day: day)
                    handler(res)
                }catch let error {
                    print("JSON error:", error)
                }
            
            }.resume()
            
        }
    }
    
    private func saveResponse(response: Response, day: Int){
        let userDefaults = UserDefaults.standard
        userDefaults.set(response.msg, forKey: PropertyKey.msg)
        userDefaults.set(response.code, forKey: PropertyKey.code)
        userDefaults.set(response.meat,forKey: PropertyKey.meat)
        userDefaults.set(response.veg, forKey: PropertyKey.veg)
        userDefaults.set(day, forKey: PropertyKey.date)
    }
 
    private func loadResponse() -> (Response?, Int) {
        let userDefaults = UserDefaults.standard
        guard
            let msg = userDefaults.string(forKey: PropertyKey.msg),
            let meat = userDefaults.string(forKey: PropertyKey.meat),
            let veg = userDefaults.string(forKey: PropertyKey.veg)
            else{
            return (nil, 0)
        }
        
        let code = userDefaults.integer(forKey: PropertyKey.code)
        let day = userDefaults.integer(forKey: PropertyKey.date)
        return (Response(msg: msg, code: code, meat: meat, veg: veg), day)
    }
    
    private struct PropertyKey {
        static let msg = "msg"
        static let code = "code"
        static let meat = "meat"
        static let veg = "veg"
        static let date = "date"
    }
}

struct Response: Decodable {
    let msg: String
    let code: Int
    let meat: String
    let veg: String
}
