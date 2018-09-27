//
//  Endpoint+Movie.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation
import Alamofire

enum MovieEndpoint: URLRequestConvertible {
    
    case movieSearch(searchString: String, pageNumber: Int)
    
    /// <#Description#>
    ///
    /// - Returns: <#return value description#>
    /// - Throws: <#throws value description#>
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .movieSearch(let searchString, let pageNumber):
            return try createURLRequest(path: RequestPath.movieSearch, method: .get, parameters: ["api_key": AppConstants.appKey, "query": searchString, "page": pageNumber], encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
        }
    }
}
