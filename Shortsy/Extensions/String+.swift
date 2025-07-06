//
//  String+.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
