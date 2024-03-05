//
//  MoviesViewModel.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import Foundation

class MoviesViewModel: BaseViewModel {
    var moviesAPI: MovieAPI
    var movies: [Movie]
    
    init(_ delegate: MoviesViewModelDelegate) {
        self.moviesAPI = MovieAPI()
        self.movies = []
        super.init(delegate)
    }
    
    func searchMovie(by text: String) {
        moviesAPI.searchMovies(title: text, success: searchMovieSucceed(response:), failure: handleFailure(error:))
    }
    
    private func searchMovieSucceed(response: MovieSearchResponse) {
        guard let delegate = delegate as? MoviesViewModelDelegate else { return }
        guard let search = response.search, response.response != "False" else {
            delegate.showAlert(alert: .noResultFound)
            return
        }
        movies = search
        delegate.didFetchSearch(movies: movies)
    }
}

protocol MoviesViewModelDelegate: ViewModelDelegate {
    func didFetchSearch(movies: [Movie])
}
