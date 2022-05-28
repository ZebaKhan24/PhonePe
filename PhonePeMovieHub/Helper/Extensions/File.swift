//
//  File.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import Foundation

extension String {
    
    func getFullUrl() -> URL? {
        let dict = ["api_key": API.apiKey]
        let str = "\(API.baseURL)\(self)?\(dict.asQuery)"
        return URL(string: str)
    }
}
