//
//  URLRequestConvertible+Endpoint.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation
import Alamofire

extension URLRequestConvertible {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - path: <#path description#>
    ///   - method: <#method description#>
    ///   - parameters: <#parameters description#>
    ///   - encoding: <#encoding description#>
    ///   - header: <#header description#>
    ///   - timeoutInterval: <#timeoutInterval description#>
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    public func createURLRequest(path: String, method: HTTPMethod = .get, parameters: Parameters? = [:], encoding: ParameterEncoding = URLEncoding.default, header: HTTPHeaders? = nil, timeoutInterval: TimeInterval? = nil) throws -> URLRequest {
        let url = try EndpointURL(path).asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let header = header {
            for (headerField, headerValue) in header {
                urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        urlRequest.timeoutInterval = timeoutInterval ?? 60
        
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
        
    }
}
