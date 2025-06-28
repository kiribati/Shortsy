//
//  Contents.Item+.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

extension Contents {
    struct Item: Identifiable {
        var id: UUID = UUID()
        var title: String?
        var url: String
        let thumbnailURL: String?
        let date: Date
        let category: Contents.Category
        let status: Contents.Status
    }
}

extension Contents.Item {
    static var sample: Self {
        .init(
            title: nil,
            url: "",
            thumbnailURL: nil,
            date: Date(),
            category: .unKnown,
            status: .unParsing
        )
    }
    
    static func create(_ url: String, date: Date) -> Contents.Item {
        return .init(url: url, thumbnailURL: nil, date: date, category: .unKnown, status: .unParsing)
    }
}
