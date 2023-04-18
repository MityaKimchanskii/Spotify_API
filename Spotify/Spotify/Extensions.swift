//
//  Extensions.swift
//  Spotify
//
//  Created by Mitya Kim on 4/12/23.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-d"
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateform = DateFormatter()
        dateform.dateStyle = .medium
        return dateform
    }()
}

extension String {
    static func formattedDate(str: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: str) else { return str }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}


