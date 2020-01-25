//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Laurent B on 25/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class GFFollowerItemVC : GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
    
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
