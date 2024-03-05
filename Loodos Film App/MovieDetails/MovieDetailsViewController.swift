//
//  MovieDetailsViewController.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: BaseViewController, MovieDetailsViewModelDelegate {
    var viewModel: MovieDetailsViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var sectionStack: UIStackView!
    @IBOutlet weak var ratingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsViewModel(self)
        if let data = data as? MovieDetailsData {
            viewModel?.setup(data: data)
        }
    }
    
    func didGetMovieDetails(movieDetailResponse: MovieDetailsResponse) {
        titleLabel.text = movieDetailResponse.title
        yearLabel.text = "\(movieDetailResponse.year) - \(movieDetailResponse.genre)"
        directorLabel.text = movieDetailResponse.director
        ratingLabel.text = movieDetailResponse.imdbRating
        addSection(title: "Plot", details: movieDetailResponse.plot)
        if !movieDetailResponse.awards.isEmpty {
            addSection(title: "Awards", details: movieDetailResponse.awards)
        }
        if let url = URL(string: movieDetailResponse.poster) {
            movieImage.kf.setImage(with: url)
        }
    }
    
    func addSection(title: String, details: String) {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        let detailsLabel = UILabel()
        detailsLabel.font = .systemFont(ofSize: 16)
        detailsLabel.numberOfLines = 0
        
        titleLabel.text = title
        detailsLabel.text = details
        let contentStack = UIStackView(arrangedSubviews: [titleLabel, detailsLabel])
        contentStack.axis = .vertical
        contentStack.spacing = 2
        sectionStack.addArrangedSubview(contentStack)
    }
}
