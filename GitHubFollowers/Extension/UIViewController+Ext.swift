//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Laurent B on 01/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        // put it on main thread! UI work has to be on main!
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
