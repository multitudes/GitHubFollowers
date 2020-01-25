//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Laurent B on 25/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class GFRepoItemVC : GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
}
