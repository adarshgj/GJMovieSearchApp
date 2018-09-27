//
//  MovieSearchResult.swift
//  MovieSearch
//
//  Created by G JAdarsh on 24/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation

struct MovieSearchResult: Decodable {
    var page: Int?
    var totalPage: Int?
    var movieList: [Movie]?
    var totalResults: Double?
    
    private enum CodingKeys : String, CodingKey {
        case page, totalPage = "total_pages", movieList = "results", totalResults = "total_results"
    }
}
