//
//  Extensions+String.swift
//  GHFollowers
//
//  Created by Mitya Kim on 12/4/24.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailFormat = ""
        let emailPredicate = NSPredicate(format: "SELF MATCHES @%", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordFormat = ""
        let passwordPredicate = NSPredicate(format: "SELF MATCHES @%", passwordFormat)
        return passwordPredicate.evaluate(with: self)
    }
}
