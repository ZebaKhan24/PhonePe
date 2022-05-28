//
//  ViewController.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import UIKit
import SDWebImage

class MovieOverviewViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    private var movieDetail: Movies?
    
    static func instanceFromStoryboard(movie: Movies) -> MovieOverviewViewController {
        let vc = UIStoryboard.main.instantiateViewController(type: MovieOverviewViewController.self)
        vc.movieDetail = movie
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        setData()
        // Do any additional setup after loading the view.
    }
    
    private func setData() {
        overview.text = movieDetail?.overview
        rating.text = "\(movieDetail?.voteAverage ?? 0)"
        releaseDate.text = movieDetail?.releaseDate
        popularity.text = "\(movieDetail?.popularity ?? 0)"
        movieImageView.sd_setImage(with: movieDetail?.posterPath?.getFullUrl(), placeholderImage: UIImage(named: "movie"))
        

    }


}

