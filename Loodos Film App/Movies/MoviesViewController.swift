//
//  MoviesViewController.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import UIKit

class MoviesViewController: BaseViewController, MoviesViewModelDelegate {
    var viewModel: MoviesViewModel?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    var movies: [Movie] {
        return viewModel?.movies ?? []
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = .init(self)
    }
    
    override func alertButtonPressed(action: AlertActions) {
        switch action {
        case .searchAgain:
            searchBar.text = ""
            searchBar.becomeFirstResponder()
        default:
            super.alertButtonPressed(action: action)
        }
    }
    
    func didFetchSearch(movies: [Movie]) {
        tableView.reloadData()
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        if indexPath.row < movies.count {
            cell.setupView(movie: movies[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        NavigationRouter.shared.push(from: self,
                                     viewPath: ViewPath(storyboard: "Main", view: "MovieDetails"),
                                     data: MovieDetailsData(id: movie.imdbID))
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel?.searchMovie(by: searchBar.text ?? "")
    }
}
