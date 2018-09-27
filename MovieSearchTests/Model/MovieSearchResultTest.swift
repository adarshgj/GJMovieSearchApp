//
//  MovieSearchResultTest.swift
//  MovieSearchTests
//
//  Created by G JAdarsh on 27/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import XCTest
@testable import MovieSearch
class MovieSearchResultTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJsonData() {
        let movieResult: MovieSearchResult = try! JSONDecoder().decode(MovieSearchResult.self, from: MovieSearchResultTest.movieSearchResultData)
        XCTAssertEqual(movieResult.page, 1)
        XCTAssertEqual(movieResult.totalResults, 106)
        XCTAssertEqual(movieResult.totalPage, 6)
        XCTAssertTrue(!(movieResult.movieList?.isEmpty)!)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    static var movieSearchResultData: Data {
        return "{\"page\":1,\"total_results\":106,\"total_pages\":6,\"results\":[{\"title\":\"Batman\",\"overview\":\"Batman\",\"release_date\":\"2005-06-10\",\"poster_path\":\"link.com\"}]}".data(using: .utf8)!
    }
    
}
