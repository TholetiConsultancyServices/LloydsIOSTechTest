//
//  NowPlayingMoviesResponse.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//


import Foundation

struct MovieList: Codable {

    private(set) var movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }

}
