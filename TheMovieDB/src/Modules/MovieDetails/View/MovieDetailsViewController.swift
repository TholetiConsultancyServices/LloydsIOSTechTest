//
//  MovieDetailsViewController.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var subTextLabel: UILabel!
 
    var viewModel : MovieDetailsViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details"
        displayViewModel()
    }

    private func displayViewModel() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        subTextLabel.text = viewModel.subText

        _ = viewModel.fetchMovieImage()
            .done { [weak self] image in
                self?.posterImageView.image = image
                self?.posterImageView.showRoundCornersWith(radius: 20)
            }

        view.setNeedsLayout()
    }
}


extension MovieDetailsViewController: StoryboardBased {
    static var storyboard: Storyboard = .main
}
