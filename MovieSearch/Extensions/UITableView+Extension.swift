//
//  UITableView+Extension.swift
//  MovieSearch
//
//  Created by G JAdarsh on 24/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit


extension UITableView {
    
    /// for adding custom tableview cell use this
    ///
    /// - Parameters:
    ///   - cellClass: custom cell class name
    ///   - indexPath: indexpath of cell
    /// - Returns: Custom cell
    func dequeueIdentifiableCell<T: UITableViewCell>(_ cellClass: T.Type, forIndexPath indexPath: IndexPath) -> T where T: IdentifiableCell {
        return self.dequeueReusableCell(withIdentifier: cellClass.cellIdentifier, for: indexPath) as! T
    }
}
