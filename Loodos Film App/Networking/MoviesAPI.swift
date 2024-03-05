//
//  MoviesAPI.swift
//  Loodos Film App
//
//  Created by Ethem Karalı on 2.03.2024.
//

import Foundation
import Alamofire

enum MovieAPIEndpoint: URLRequestConvertible {
    case search(title: String)
    case details(id: String)

    func asURLRequest() throws -> URLRequest {
        let baseUrl = URL(string: "http://www.omdbapi.com")!
        var path: String {
            switch self {
            default:
                return ""
            }
        }
        
        let url = baseUrl.appendingPathComponent(path)
        var request = URLRequest(url: url)
        
        var parameters = ["apikey": "3a096f1d"]
        switch self {
        case .search(let title):
            request.method = .get
            parameters["s"] = title
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        case .details(let id):
            request.method = .get
            parameters["i"] = id
            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        }
        
        return request
    }
}

class MovieAPI: BaseAPI {
    func searchMovies(title: String, success: @escaping (MovieSearchResponse) -> Void, failure: @escaping (Error) -> Void) {
        let endpoint = MovieAPIEndpoint.search(title: title)
        request(endpoint, success: success, failure: failure)
    }
    
    func getMovieDetails(id: String, success: @escaping (MovieDetailsResponse) -> Void, failure: @escaping (Error) -> Void) {
        let endpoint = MovieAPIEndpoint.details(id: id)
        request(endpoint, success: success, failure: failure)
    }
}

