//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Laurent B on 30/12/2019.
//  Copyright © 2019 Laurent B. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    // initializers. you init a button with the frame!§
    override init(frame: CGRect) {
        //when you subclass an object you build on top of it so need to init the uibutton first then add our own tweaks
        super.init(frame: frame)
        configure()
    }
    // this is required when using storyboard. We need it but in this app we do not have storyboards..
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String){
        // init with zero our custom init because I will use the autolayout anyway / however need to pass color and title
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // this is necessary to use autolayout!
        translatesAutoresizingMaskIntoConstraints = false
    }
}
