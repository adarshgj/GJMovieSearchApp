//
//  Movie.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var movieName: String?
    var movieOverview: String?
    var moviePosterPath: String?
    var movieReleaseDate: String?
    
    private enum CodingKeys : String, CodingKey {
        case movieName = "title", movieOverview = "overview", moviePosterPath = "poster_path", movieReleaseDate = "release_date"
    }
}
