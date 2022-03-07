//
//  MovieListViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import XCTest
import PromiseKit

@testable import TheMovieDB

class MovieListViewModelTests: XCTestCase {

    private var service: MockMovieService!
    private var delegate: MockMovieListCoordinatorDelegate!

    private var sut: MovieListViewModel!

    override func setUpWithError() throws {
        service = MockMovieService()
        delegate = MockMovieListCoordinatorDelegate()
        sut = MovieListViewModel(service: service, delegate: delegate)
    }

    override func tearDownWithError() throws {
        service = nil
        delegate = nil
        sut = nil
    }

    func test_LoadMovies_WhenSuccesful_ReturnsValidMovieViewItems() {
        // Given
        let expectation = self.expectation(description: "Fetch Movies")

        guard let movieList: MovieList = TestUtils().loadJson(filename: "moviedb_now_playing") else {
            XCTFail()
            return
        }

        service.fetchNowPlayingMoviesGivenValue = movieList

        var movieItems: [MovieViewItem]?

        // When
        _ = sut.loadMovies()
            .done { items in
                movieItems = items
                expectation.fulfill()
            }


        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(movieItems?.count, 20)
        guard let movieItem = movieItems?[0] else {
            XCTFail()
            return
        }

        XCTAssertEqual( movieItem.subTitle, "October 2021")
        XCTAssertEqual( movieItem.title, "Venom")
    }

    func test_LoadMovies_WhenFailed_ReturnsErrorMessage() {
        // Given
        let expectation = self.expectation(description: "Fetch Movies")

        service.fetchNowPlayingMoviesGivenValue = nil

        var expectedDownloadError: DownloadError?

        // When
        sut.loadMovies()
            .catch { error in
                guard let downloadError = error as? DownloadError else { return }
                expectedDownloadError = downloadError
                expectation.fulfill()
            }

        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedDownloadError?.message, DownloadError.generic.message)
    }

    func test_FetchImage_ReturnsUIImage() {
        // Given
        let expectation = self.expectation(description: "Movie Image")

        let imageData = TestUtils().loadImageData(filename: "clapboard")
        service.fetchPosterImageReturnValue = imageData
        let movie = Movie(id: 123, title: "title", posterPath: "posterPath", overview: "overview", releaseDate: Date())
        let movieItem = MovieViewItem(movie)

        var expetedImage: UIImage?
        //When
        _ = sut.fetchImage(for: movieItem)
            .done { image in
                expetedImage = image
                expectation.fulfill()
            }

        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(expetedImage)
    }

    func test_DidSelect_CallsCoOrdinatorDelagateWithCorrectMovieModel() {
        // Given
        let movie = Movie(id: 123, title: "title", posterPath: "posterPath", overview: "overview", releaseDate: Date())
        let movieViewItem = MovieViewItem(movie)

        //When
        sut.didSelect(item: movieViewItem)

        //Then
        XCTAssertTrue(delegate.showMovieDetailsCalled)
    }
}

class MockMovieListCoordinatorDelegate: MovieListCoordinatorDelegate {
    var showMovieDetailsCalled = false
    func showMovieDetails(movie: Movie) {
        showMovieDetailsCalled = true
    }
}
