//
//  NetworkManager.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit
import Alamofire
class NetworkManager {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completion: <#completion description#>
    func objectRequest<T: Decodable>(_ url: URLRequestConvertible, completion:  @escaping (_ result: Result<T>) -> ()) {
        SessionManager.default.request(url).response { response in
        let decoder = JSONDecoder()
        let decodedResponse: Result<T> = decoder.decodeResponse(from: response)
            DispatchQueue.main.async {
                completion(decodedResponse)
            }
        }
    }
    
}

extension JSONDecoder {
    
    /// <#Description#>
    ///
    /// - Parameter response: <#response description#>
    /// - Returns: <#return value description#>
    func decodeResponse<T: Decodable>(from response: DefaultDataResponse) -> Result<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(SpecificRequestError.noURLForEndpointAvailable)
        }
    
        do {
            let item = try decode(T.self, from: responseData)
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}
