//
//  Enums.swift
//  PhonePeMovieHub
//
//  Created by Zeba Khan on 28/05/22.
//

import Foundation

enum API {
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "38a73d59546aa378980a88b645f487fc"
    case getMovies
    
    var path: String {
        switch self {
        case .getMovies:
            return "/movie/popular"
        }
    }
}

public enum FilteredError: Error {
    case unknownError
    case connectionError
    case invalidCredentials
    case invalidLoginRequest
    case userCancelled
    case unknownWithMessage(with: String)
    case unknown(error: Error)
    case stillFetchingData

    var localizedDescription: String {
        switch self {
        case .unknown(error: let error):
            return error.localizedDescription
        case .unknownWithMessage(with: let message):
            return message
        case .userCancelled:
            return "User cancelled..."
        case .invalidLoginRequest:
            return "This login request is not allowed for platform"
        case .unknownError:
            return "Something went wrong"
        case .stillFetchingData:
            return "Please try after sometime"
        default:
            return (self as Error).localizedDescription
        }
    }
}
