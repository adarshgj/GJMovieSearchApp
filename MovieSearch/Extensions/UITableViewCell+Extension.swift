//
//  UITableViewCell+Extension.swift
//  MovieSearch
//
//  Created by G JAdarsh on 24/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import Foundation

protocol IdentifiableCell {
    static var cellIdentifier: String { get }
}

extension IdentifiableCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}
