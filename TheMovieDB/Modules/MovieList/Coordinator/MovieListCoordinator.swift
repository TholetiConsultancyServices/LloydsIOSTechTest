//
//  NowPlayingMoviesCoordinator.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

protocol  MovieListCoordinatorDelegate: AnyObject {
    func showMovieDetails(movie: Movie)
}

final class MovieListCoordinator: CoordinatorType {
    var parentCoordinator: CoordinatorType?
    var childCoordinators: [CoordinatorType] = []

    private var window: UIWindow
    private lazy var navigationController: UINavigationController  = {
        return UINavigationController()
    }()

    private let service: MovieService

    init(window: UIWindow, service: MovieService = MovieService()) {
        self.window = window
        self.service = service
    }

    func start() {
        let viewModel = MovieListViewModel(service: service, delegate: self)
        let viewController = MovieListViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension MovieListCoordinator: MovieListCoordinatorDelegate {
    func showMovieDetails(movie: Movie) {
        let coordinator = MovieDetailsCoordinator(movie: movie, navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
