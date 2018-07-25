//
//  MoviesListTableViewController.swift
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MoviesListTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    var movies: [ZMFMovie] = []
    
    // MARK: - UISearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty, searchText != " " else { return }
        searchBar.text = " "
        self.resignFirstResponder()
        ZMFMovieController.shared().retrieveMovies(searchText) { (movies) in
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailView" {
            guard let destinationVC = segue.destination as? MovieDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            let movie = movies[indexPath.row]
            destinationVC.title = movie.title
            destinationVC.movie = movie
        }
        
    }

}
