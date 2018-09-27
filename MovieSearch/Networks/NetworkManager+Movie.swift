//
//  NetworkManager+Movie.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation
import Alamofire
extension NetworkManager {

    /// Search movie
    ///
    /// - Parameters:
    ///   - searchString: Querey string
    ///   - page: page Number to fetch
    ///   - completion: This block contain Result with movie list
    func searchMovie(_ searchString: String, pageNumber page: Int, completion: @escaping (Result<MovieSearchResult>) -> Void) {
        self.objectRequest(MovieEndpoint.movieSearch(searchString: searchString, pageNumber: page), completion: completion)
    }
}
