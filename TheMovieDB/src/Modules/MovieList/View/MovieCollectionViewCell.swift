//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 06/03/2022.
//  Copyright © 2021 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit


class MovieCollectionViewCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil)
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var subTitleBackground: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleLabelBackground: UIView!
    
    static var reuseIdentifier: String {
        return "MovieCollectionViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.alpha = 0.8
        subTitleBackground.layer.cornerRadius = subTitleBackground.frame.height / 2
        subTitleBackground.layer.borderWidth = 1
        subTitleBackground.layer.borderColor = UIColor.white.cgColor
        
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subTitleLabel.text = nil
        posterImageView.image = nil
        posterImageView.contentMode = .center
        posterImageView.image = UIImage(named: "poster_placeholder")
    }
    
    func configureContent(_ item: MovieViewItem) {
        titleLabel.text = item.title
        subTitleLabel.text = item.subTitle
    }
    
    func updateImage(image: UIImage?) {
        posterImageView.image = image
    }
}

