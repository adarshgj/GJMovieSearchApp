//
//  MovieSearchTableViewController.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit

class MovieSearchTableViewController: UITableViewController {
    
    private var movieList: [Movie] = []
    private var totalPage = 0
    private var currentPage = 1
    
    private lazy var requestManager = NetworkManager()
    
    private var recentSearchList: [String] = []
    private var filteredRecentSearchList: [String]? = nil
    
    private var enableLoadMore: Bool {
        return !(totalPage == currentPage)
    }
    
    private lazy var searchController = self.searchBarController()
    
    // TODO: Text needs to be localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Search"
        //Set search as tableview header
        self.tableView.tableHeaderView = self.searchController.searchBar
        
        self.recentSearchList = UserDefaults.standard.value(forKey: AppConstants.UserDefaultsKeys.recentSearchListKey) as? [String] ?? []
    }
    
    private func searchBarController() -> UISearchController {
        let searchBarController = UISearchController(searchResultsController: nil)
        searchBarController.dimsBackgroundDuringPresentation = false
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.searchBar.showsCancelButton = false
        searchBarController.searchResultsUpdater = self
        searchBarController.searchBar.delegate = self
        searchBarController.delegate = self
        searchBarController.searchBar.placeholder = "Enter movie name"
        return searchBarController
    }
    
    /// Clear content before fresh search
    private func clearSearchContent() {
        self.currentPage = 1
        self.totalPage = 0
        self.filteredRecentSearchList = nil
        self.movieList.removeAll()
    }
    
    /// Call webservice and get the data
    private func loadMoreMovie(isFirstLoad: Bool = false) {
        self.requestManager.searchMovie(self.searchController.searchBar.text ?? "", pageNumber: self.currentPage) { [weak self] result in
            guard let strongSelf = self else { return }
            guard let movieSearchResult = result.value else {
                print("Error \(result.error?.localizedDescription ?? "")")
                strongSelf.showAlertController(message: result.error?.localizedDescription ?? "")
                return
            }
            strongSelf.totalPage = movieSearchResult.totalPage ?? 1
            strongSelf.movieList += movieSearchResult.movieList ?? []
            if isFirstLoad {
                if strongSelf.movieList.count == 0 {
                    strongSelf.showAlertController(message: "No Result")
                } else {
                    strongSelf.saveSearchText(strongSelf.searchController.searchBar.text ?? "")
                }
            }
            strongSelf.tableView.reloadData()
        }
    }
    
    private func showAlertController(title: String = "Movie Search", message: String) {
        self.searchController.dismiss(animated: true)
        let alertView = UIAlertController.showAlertController(title: title, message: message)
        self.present(alertView, animated: true, completion: nil)
    }
    
    /// Save recent search key in list
    ///
    /// - Parameter searchText: search text
    private func saveSearchText(_ searchText: String) {
        guard !self.recentSearchList.contains(searchText) else { return }
        if self.recentSearchList.count == 10 {
            self.recentSearchList.removeLast()
        }
        self.recentSearchList.insert(searchText, at: 0)
        UserDefaults.standard.setValue(self.recentSearchList, forKey: AppConstants.UserDefaultsKeys.recentSearchListKey)
    }
    
}

// MARK: - Table view data source

extension MovieSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // If filteredRecentSearchList alue is there then only we are going to show the recent search content otherwise show the movie list
        guard let filteredRecentSearchList = self.filteredRecentSearchList else {
            let numberOfRows = self.movieList.count
            return (numberOfRows != 0 && self.enableLoadMore) ? numberOfRows+1 : numberOfRows
        }
        return filteredRecentSearchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // If filteredRecentSearchList alue is there then only we are going to show the recent search content otherwise show the movie list
        guard self.filteredRecentSearchList == nil else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            cell.textLabel?.text = self.filteredRecentSearchList?[indexPath.row]
            return cell
        }
        guard indexPath.row == self.movieList.count else {
            let cell = tableView.dequeueIdentifiableCell(MovieTableViewCell.self, forIndexPath: indexPath)
            cell.movie = self.movieList[indexPath.row]
            return cell
        }
        
        let cell = tableView.dequeueIdentifiableCell(LoadingTableViewCell.self, forIndexPath: indexPath)
        cell.activityIndicatorView.startAnimating()
        return cell
    }
}

// MARK: - UITableView Delegate
extension MovieSearchTableViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard self.filteredRecentSearchList == nil else { return }
        
        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
        //If last cell reach and enableLoadMore is true then increment the page number and call the API for next page fetch.
        if indexPath.row == lastRowIndex && self.enableLoadMore {
            self.currentPage += 1
            loadMoreMovie()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let filteredRecentSearchList = self.filteredRecentSearchList else { return }
        self.searchController.searchBar.resignFirstResponder()
        self.clearSearchContent()
        self.searchController.searchBar.text = filteredRecentSearchList[indexPath.row]
        self.loadMoreMovie(isFirstLoad: true)
    }
}

// MARK: - UISearchResultsUpdating
extension MovieSearchTableViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard self.filteredRecentSearchList != nil else { return }
        
        // If search text empty show all recent search otherwise filter recent search list
        if let searchText = searchController.searchBar.text, searchText.trimmingCharacters(in: .whitespaces).isEmpty == false {
            self.filteredRecentSearchList = self.recentSearchList.filter { $0.lowercased().contains(searchText.lowercased()) }
        } else {
            self.filteredRecentSearchList = self.recentSearchList
        }
        self.tableView.reloadData()
    }
}

// MARK: - UISearchControllerDelegate
extension MovieSearchTableViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.showsCancelButton = false
    }
}

// MARK: - UISearchBarDelegate
extension MovieSearchTableViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.filteredRecentSearchList = self.recentSearchList
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty == false else { return }
        searchBar.resignFirstResponder()
        self.clearSearchContent()
        self.loadMoreMovie(isFirstLoad: true)
    }
}

// MARK: - Unit text
extension MovieSearchTableViewController {
    
    func loadLastSearchList(_ lastSearchList: [String]) {
        self.clearSearchContent()
        self.filteredRecentSearchList = lastSearchList
        self.tableView.reloadData()
    }
    
    func loadMoreMovie(_ movieArray: [Movie]) {
        self.clearSearchContent()
        self.movieList = movieArray
        self.tableView.reloadData()
    }
}


