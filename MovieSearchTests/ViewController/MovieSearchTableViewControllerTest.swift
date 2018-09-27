//
//  MovieSearchTableViewControllerTest.swift
//  MovieSearchTests
//
//  Created by G JAdarsh on 27/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieSearchTableViewControllerTest: XCTestCase {
    
    var movieSearchTableViewController: MovieSearchTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.movieSearchTableViewController = storyboard.instantiateViewController(withIdentifier: "MovieSearchTableViewController") as! MovieSearchTableViewController
        
        self.movieSearchTableViewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(movieSearchTableViewController.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(movieSearchTableViewController.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(movieSearchTableViewController.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(movieSearchTableViewController.responds(to: #selector(movieSearchTableViewController.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(movieSearchTableViewController.tableView.dataSource)
    }
    
    func testSearchBarInTableViewHeaderView() {
        XCTAssertNotNil(movieSearchTableViewController.tableView.tableHeaderView as? UISearchBar)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(movieSearchTableViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(movieSearchTableViewController.responds(to: #selector(movieSearchTableViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(movieSearchTableViewController.responds(to: #selector(movieSearchTableViewController.tableView(_:cellForRowAt:))))
    }
    
    func testMovieSearchContent() {
        movieSearchTableViewController.loadMoreMovie([Movie(movieName: "batman", movieOverview: "good", moviePosterPath: "path", movieReleaseDate: "2005-06-10")])
        let cell = movieSearchTableViewController.tableView(movieSearchTableViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? MovieTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "MovieTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testLastSearchContent() {
        movieSearchTableViewController.loadLastSearchList(["batman"])
        let cell = movieSearchTableViewController.tableView(movieSearchTableViewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell.reuseIdentifier
        let expectedReuseIdentifier = "defaultCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    
}
