//
//  MoviesCollectionViewCell.swift
//  assignment
//
//  Created by IOS Developer6 on 15/02/18.
//  Copyright © 2018 sachin. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImgView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
