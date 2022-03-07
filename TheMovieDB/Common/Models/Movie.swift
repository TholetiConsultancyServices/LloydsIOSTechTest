//
//  Movie.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let releaseDate: Date
    
    
    // MARK: Codable Protocol
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        overview = try container.decode(String.self, forKey: .overview)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        releaseDate = DateTransformer.transform(dateString)
    }

    init(id: Int, title: String,  posterPath: String, overview: String, releaseDate: Date) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.overview = overview
    }
}
