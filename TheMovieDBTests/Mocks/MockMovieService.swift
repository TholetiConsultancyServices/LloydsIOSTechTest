//
//  MockMovieService.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import XCTest
import PromiseKit

@testable import TheMovieDB

class MockMovieService: MovieServiceType {

    var fetchNowPlayingMoviesCalled = false
    var fetchPosterImageCalled = false
    var fetchNowPlayingMoviesGivenValue: MovieList?
    var fetchPosterImageReturnValue: Data?

    func fetchNowPlayingMovies() -> Promise<MovieList> {
        fetchNowPlayingMoviesCalled = true
        guard let list = fetchNowPlayingMoviesGivenValue else {
            return brokenPromise()
        }

        return Promise.value(list)
    }

    func fetchPosterImage(path: String) -> Promise<Data> {
        fetchPosterImageCalled = true
        guard let data = fetchPosterImageReturnValue else {
            return brokenPromise()
        }

        return Promise.value(data)
    }
    
}
