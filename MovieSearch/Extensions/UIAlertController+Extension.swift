//
//  UIAlertController+Extension.swift
//  MovieSearch
//
//  Created by G JAdarsh on 27/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    /// Show alert  controller
    ///
    /// - Parameters:
    ///   - title: title for alert controller
    ///   - message: message for alertcontroller
    /// - Returns: UIAlertController
    static func showAlertController(title: String, message: String) -> UIAlertController {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertView
    }
}
