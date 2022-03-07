//
//  NowPlayingMoviesCoordinator.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

final class MovieDetailsCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    private let navigationController: UINavigationController
    private let service: MovieService
    private let movie: Movie

    init(movie: Movie, navigationController: UINavigationController, service: MovieService = MovieService()) {
        self.navigationController = navigationController
        self.service = service
        self.movie = movie
    }

    func start() {
        let viewModel = MovieDetailsViewModel(movie: movie, moviesService: service)
        let viewController = MovieDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
