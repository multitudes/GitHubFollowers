//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Laurent B on 23/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

   
    override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
      }

      init(fontSize: CGFloat) {
          super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium )
            configure()
      }
      
      private func configure() {
          textColor = .secondaryLabel
          adjustsFontSizeToFitWidth = true
          minimumScaleFactor = 0.90
          lineBreakMode = .byTruncatingTail
          translatesAutoresizingMaskIntoConstraints = false
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }


}
