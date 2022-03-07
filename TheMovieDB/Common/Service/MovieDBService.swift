//
//  MovieService.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import PromiseKit


protocol MovieServiceType {
    func fetchNowPlayingMovies() -> Promise<MovieList>
    func fetchPosterImage(path: String) -> Promise<Data>
    
}

private let apiKey = "f7ae5a29253b3db883e101050692f0a8"

struct MovieServiceEndPoints {
    static let theMoviesDB = "https://api.themoviedb.org/3"
    static let nowPlaying = "/movie/now_playing"
    static let posterImage = "http://image.tmdb.org/t/p/w185"
}

struct MovieService: MovieServiceType {

    func fetchPosterImage(path: String) -> Promise<Data> {
        let urlString = MovieServiceEndPoints.posterImage.appending(path)
        guard let url =  URL(string: urlString) else {
            return brokenPromise()
        }

        return firstly {
          URLSession.shared.dataTask(.promise, with: url)
        }
        .then(on: DispatchQueue.global(qos: .background)) { urlResponse in
            return Promise.value(urlResponse.data)
        }
    }

    func fetchNowPlayingMovies() -> Promise<MovieList> {

        guard let url =  self.requestURL(from: MovieServiceEndPoints.nowPlaying) else {
            return brokenPromise()
        }

        return firstly {
          URLSession.shared.dataTask(.promise, with: url)
        }
        .compactMap {
           return try JSONDecoder().decode(MovieList.self, from: $0.data)
        }
    }
}

private extension MovieService {
   
    func requestURL(from path: String) -> URL? {
        
        let urlString = MovieServiceEndPoints.theMoviesDB.appending(path)
        guard let url = URL(string: urlString),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)   else {
            return nil
        }
        
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [apiKeyItem]
        return components.url
        
    }
}

