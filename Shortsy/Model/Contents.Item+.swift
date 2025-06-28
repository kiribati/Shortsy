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
        var title: String
        var url: URL
        let thumbnailURL: String
        let dateString: Date
        let category: Contents.Category
    }
}

extension Contents.Item {
    static var sample: Self {
        .init(
            title: "Sample Title",
            url: URL(string: "https://example.com")!,
            thumbnailURL: "https://example.com/thumbnail.jpg",
            dateString: Date(),
            category: .cafe
        )
    }
}
