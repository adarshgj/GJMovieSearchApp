//
//  MovieTest.swift
//  MovieSearchTests
//
//  Created by G JAdarsh on 27/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testJsonData() {
        let movie: Movie = try! JSONDecoder().decode(Movie.self, from: MovieTest.movieData)
        XCTAssertEqual(movie.movieName, "Batman")
        XCTAssertEqual(movie.movieReleaseDate, "2005-06-10")
        XCTAssertEqual(movie.moviePosterPath, "link.com")
    }
    
    static var movieData: Data {
        return "{\"title\":\"Batman\",\"overview\":\"Batman\",\"release_date\":\"2005-06-10\",\"poster_path\":\"link.com\"}".data(using: .utf8)!
    }
}
