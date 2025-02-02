//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Laurent B on 01/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
          super.init(frame: frame)
          configure()
      }

      init(textAlignment: NSTextAlignment) {
          super.init(frame: .zero)
          self.textAlignment = textAlignment
          configure()
      }
      
      private func configure() {
          textColor = .secondaryLabel
          font = UIFont.preferredFont(forTextStyle: .body)
          adjustsFontSizeToFitWidth = true
          minimumScaleFactor = 0.75
          lineBreakMode = .byWordWrapping
          translatesAutoresizingMaskIntoConstraints = false
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}
