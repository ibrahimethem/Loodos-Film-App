//
//  MovieDetailsViewModel.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import Foundation
import FirebaseAnalytics

struct MovieDetailsData: ViewModelData {
    var id: String
}

class MovieDetailsViewModel: BaseViewModel {
    var movieAPI: MovieAPI
    
    init(_ delegate: MovieDetailsViewModelDelegate) {
        self.movieAPI = MovieAPI()
        super.init(delegate)
    }
    
    func setup(data: MovieDetailsData) {
        getMovieDetails(id: data.id)
    }
    
    func getMovieDetails(id: String) {
        movieAPI.getMovieDetails(id: id, success: getMovieDetailsSucceed(response:), failure: handleFailure(error:))
    }
    
    private func getMovieDetailsSucceed(response: MovieDetailsResponse) {
        guard let delegate = delegate as? MovieDetailsViewModelDelegate else { return }
        delegate.didGetMovieDetails(movieDetailResponse: response)
        Analytics.logEvent("Test", parameters: ["title": response.title])
    }
}

protocol MovieDetailsViewModelDelegate: ViewModelDelegate {
    func didGetMovieDetails(movieDetailResponse: MovieDetailsResponse)
}
