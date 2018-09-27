//
//  LoadingTableViewCell.swift
//  MovieSearch
//
//  Created by G JAdarsh on 25/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell, IdentifiableCell {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
