//
//  MovieTableViewController.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet var popularMovieTableView: UITableView!
    
    private let popularViewModel = MoviePopularViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        getData()
    }
    
    static func instanceFromStoryboard() -> MovieTableViewController {
        return UIStoryboard.main.instantiateViewController(type: MovieTableViewController.self)
    }
    
    private func getData() {
        popularViewModel.getPopularMovie { [weak self] error in
            self?.popularMovieTableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return popularViewModel.movieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMovieTableViewCell", for: indexPath) as! PopularMovieTableViewCell
        cell.movieDetail = popularViewModel.movieList[indexPath.row]
        // Configure the cell...
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieOverviewViewController.instanceFromStoryboard(movie: popularViewModel.movieList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height + 8 * 60 >= scrollView.contentSize.height {
            getData()
        }
    }

}
