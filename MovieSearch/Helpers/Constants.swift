//
//  Constants.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation

struct AppConstants {
    static let appKey = "2696829a81b1b5827d515ff121700838"
    struct URLs {
        static let serverBaseURL = "http://api.themoviedb.org/3/"
        static let imageBaseURL = "http://image.tmdb.org/t/p/w92/"
    }
    
    struct UserDefaultsKeys {
        static let recentSearchListKey = "recentSearchList"
    }
}
