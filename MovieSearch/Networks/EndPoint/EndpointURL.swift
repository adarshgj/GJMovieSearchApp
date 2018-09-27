//
//  EndpointURL.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation
import Alamofire
public struct EndpointURL: URLConvertible {
    
    public let endpointURL: URL?
    
    init(_ urlString: String) {
        
        if !urlString.hasPrefix("http") {
            // if the given url string doesn't begin withh http, assume it is an endpoint and prepend our baseurl to it
            self.endpointURL = URL(string: AppConstants.URLs.serverBaseURL)?.appendingPathComponent(urlString)
        } else {
            self.endpointURL = URL(string: urlString)
        }
        assert(self.endpointURL != nil, "Invalid url '\(urlString)")
    }
    
    public init(_ url: URL) {
        self.endpointURL = url
    }
    
    // MARK:- Conform to URLConvertible
    public func asURL() throws -> URL {
        guard let endpointURL = self.endpointURL else {  throw SpecificRequestError.noURLForEndpointAvailable }
        return endpointURL
    }
    
}

enum SpecificRequestError: String, LocalizedError {
    case noURLForEndpointAvailable = "No URL For Endpoint Available"
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "")}
}
