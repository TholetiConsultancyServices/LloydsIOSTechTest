//
//  NowPlayingMoviesResponseTests.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import XCTest
@testable import TheMovieDB


class MovieListModelTests: XCTestCase {

    func testNowPlayingMovieResponseModel() {
        guard let movieList: MovieList = TestUtils().loadJson(filename: "moviedb_now_playing") else {
            XCTAssertThrowsError("unable to load file")
            return
        }
        XCTAssertEqual(movieList.movies?.count, 20)
        let movie = movieList.movies![0]
        XCTAssertEqual(movie.id, 335983)
        XCTAssertEqual(movie.title, "Venom")
        XCTAssertEqual(movie.posterPath, "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        XCTAssertEqual(movie.releaseDate, DateTransformer.transform("2021-10-03"))

    }
    
}
