//
//  BaseRouter.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import Foundation
import SwiftyJSON

enum HTTPMethod {
    case get
    case post
    case put
    
    var value: String {
        get {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            }
        }
    }
}

class BaseRouter {
    static let shared: BaseRouter = BaseRouter()
    
    func getData<T: Codable>(urlString: String, params: [URLQueryItem]? = nil, headers: [String: String]? = nil, method: HTTPMethod, completion: @escaping(T)->()) {
        var urlBuilder = URLComponents(string: urlString)
        urlBuilder?.queryItems = params
        
        guard let url = urlBuilder?.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.value
        urlRequest.cachePolicy = .useProtocolCachePolicy
        urlRequest.timeoutInterval = 30.0
        urlRequest.allHTTPHeaderFields = headers
        //        urlRequest.setValue("value", forHTTPHeaderField: "key")
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            if let data = data {
                print("fullURLRequest: ", url)
                print("params: ", url.query as Any)
                print("header: ", url.absoluteURL)
                if let json = try? JSON(data: data) {
                    print("Response json:\n", json as Any)
                }
            }
            guard let data = data else { return }
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch let error {
                print("decode error: ", error)
            }
        })
        dataTask.resume()
    }
}
