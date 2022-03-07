//
//  MovieDetailsViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import XCTest
import PromiseKit

@testable import TheMovieDB

class MovieDetailsViewModelTests: XCTestCase {

    private var service: MockMovieService!

    private var sut: MovieDetailsViewModel!

    override func setUpWithError() throws {
        service = MockMovieService()
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func test_MovieImage_ReturnsUIImage() {
        // Given
        let expectation = self.expectation(description: "Movie Image")

        let imageData = TestUtils().loadImageData(filename: "clapboard")
        service.fetchPosterImageReturnValue = imageData
        let movie = Movie(id: 123, title: "title", posterPath: "posterPath", overview: "overview", releaseDate: Date())

        var expetedImage: UIImage?

        //When
        sut = MovieDetailsViewModel(movie: movie, moviesService: service)
        _ = sut.fetchMovieImage()
            .done { image in
                expetedImage = image
                expectation.fulfill()
            }

        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(expetedImage)
    }
}
