//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/20/24.
//

import Foundation


extension Date {
    func convertToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
