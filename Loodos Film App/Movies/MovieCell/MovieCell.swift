//
//  MovieCell.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 3.03.2024.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func setupView(movie: Movie) {
        movieTitle.text = movie.title
        movieYear.text = movie.year
        if let imageURL = URL(string: movie.poster) {
            movieImage.kf.setImage(with: imageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
