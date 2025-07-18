//
//  Color+.swift
//  Shortsy
//
//  Created by Brown on 7/9/25.
//

import SwiftUI

extension Color {
    static let midnightBlue = Color(red: 54/255, green: 56/255, blue: 76/255)
    
    // 헥스 컬러 지원 익스텐션
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hex)
        if hex.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xff) / 255
        let g = Double((rgb >> 8) & 0xff) / 255
        let b = Double(rgb & 0xff) / 255
        self.init(red: r, green: g, blue: b)
    }
}

