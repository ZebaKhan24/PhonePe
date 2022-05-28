//
//  MoviePopularViewModel.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import UIKit

class MoviePopularViewModel {
    
    var movieList = [Movies]()
    
    private var popularMovieResponse: PopularMovie? {
        didSet {
            if let list = popularMovieResponse?.results {
                if movieList.count > 0 {
                    movieList.append(contentsOf: list)
                } else {
                    movieList = list
                }
            }
        }
    }
    private var hasNext = true
    private var service = Service()
    private var isLoading = false
    
    func getPopularMovie(completion: @escaping (_ error: FilteredError?) -> Void) {
        if (hasNext == true && isLoading == false){
            isLoading = true
            var params = [String: Any]()
            params["page"] = self.popularMovieResponse?.page == nil ? 1 : (self.popularMovieResponse?.page ?? 0) + 1
            params["api_key"] = API.apiKey
            service.get(API.getMovies, parameters: params) { [weak self] responseData, _, error, responseCode in
                self?.isLoading = false
                if let data = responseData, responseCode == 200 {
                    self?.popularMovieResponse = try? JSONDecoder().decode(PopularMovie.self, from: data)
                    self?.hasNext = (self?.popularMovieResponse?.page ?? 1 + 1)  < self?.popularMovieResponse?.totalPages ?? 0
                    completion(nil)
                } else {
                    completion(error ?? FilteredError.unknownError)
                }
            }
        } else {
            print("nothing to get")
            completion(FilteredError.stillFetchingData)
        }
    }

}
