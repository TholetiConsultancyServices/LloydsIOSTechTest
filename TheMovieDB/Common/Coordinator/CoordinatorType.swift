//
//  CoordinatorType.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorType: AnyObject {
    var parentCoordinator: CoordinatorType? { get set }
    var childCoordinators: [CoordinatorType] { get set }
    func start()
    func didFinish(coordinator: CoordinatorType)
}

extension CoordinatorType {
    func didFinish(coordinator: CoordinatorType) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}


