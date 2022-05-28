//
//  PopularMovieTableViewCell.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import UIKit
import SDWebImage

class PopularMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    var movieDetail: Movies? {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setData() {
        movieDescription.text = movieDetail?.overview
        name.text = movieDetail?.title
        movieImage.sd_setImage(with: movieDetail?.posterPath?.getFullUrl(), placeholderImage: UIImage(named: "movie"))
    }

}
