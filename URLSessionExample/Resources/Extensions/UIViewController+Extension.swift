//
//  UIViewController+Extension.swift
//  URLSessionsExample
//
//  Created by APPLE on 12/02/2021.
//  Copyright © 2021 Javier Roche. All rights reserved.
//

import UIKit

extension UIViewController {
    /// UIAlertController con una sola accion
    func showAlert(message: String, title: String, alertActionTitle: String = "Accept") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
