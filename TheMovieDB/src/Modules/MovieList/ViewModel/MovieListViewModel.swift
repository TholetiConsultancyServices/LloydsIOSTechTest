//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import PromiseKit

struct DownloadError: Error {
    let message: String
}

struct MovieViewItem {
    private(set) var movie: Movie
    let title: String
    let imageUrl: String
    let subTitle: String

    init(_ movie: Movie) {
        self.movie = movie
        title = movie.title
        imageUrl = movie.posterPath
        subTitle = DateFormatter.string(from: movie.releaseDate, format: "MMMM YYYY")
    }
}

protocol MovieListViewModelType {
    var title: String? { get }

    func didSelect(item: MovieViewItem)
    func loadMovies() -> Promise<[MovieViewItem]>
    func fetchImage(for item: MovieViewItem) -> Promise<UIImage>
}


class MovieListViewModel: MovieListViewModelType {
    private let service: MovieServiceType
    var movieItems: [MovieViewItem]?
    private weak var delegate: MovieListCoordinatorDelegate?


    init(service: MovieServiceType, delegate: MovieListCoordinatorDelegate? = nil) {
        self.service = service
        self.delegate = delegate
    }

    var title: String? {
        return "Now Playing"
    }


    func didSelect( item: MovieViewItem) {
        delegate?.didSelect(movie: item.movie)
    }

    func fetchImage(for item: MovieViewItem) -> Promise<UIImage> {
        return service.fetchPosterImage(path: item.imageUrl)
            .compactMap {  UIImage(data: $0) }
    }

    func loadMovies() -> Promise<[MovieViewItem]> {
        return Promise { seal in
            service.fetchNowPlayingMovies()
                .done(on: DispatchQueue.main) { list in
                     self.movieItems = list.movies?.compactMap( { MovieViewItem($0) })
                    seal.fulfill(self.movieItems ?? [])
                }
                .catch { error in
                    switch error {
                    case is URLError:
                        guard let code = (error as? URLError)?.code else { return }
                        if code == URLError.notConnectedToInternet {
                            seal.reject(DownloadError(message: "Internet seems to be offline, please check the internet connection."))
                        } else {
                            seal.reject(DownloadError(message: "Unable to load movies, please try again."))
                        }
                    default:
                        seal.reject(DownloadError(message: "Unable to load movies, please try again."))
                    }
                }
        }
    }
}
