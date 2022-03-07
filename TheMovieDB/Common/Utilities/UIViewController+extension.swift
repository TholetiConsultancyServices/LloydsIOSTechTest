//
//  UserAlert.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func present(withTitle title: String, description: String? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(dismissAction)
        present(alert, animated: true, completion: nil)
    }
}
