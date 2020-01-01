//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Laurent B on 01/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }

}
