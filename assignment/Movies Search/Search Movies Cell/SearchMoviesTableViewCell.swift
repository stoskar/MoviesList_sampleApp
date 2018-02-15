//
//  SearchMoviesTableViewCell.swift
//  CollectionView
//
//  Created by sachin toskar on 15/02/18.
//  Copyright © 2018 IOS Developer6. All rights reserved.
//

import UIKit

class SearchMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var moviesName: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
