//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Laurent B on 25/01/2020.
//  Copyright © 2020 Laurent B. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
