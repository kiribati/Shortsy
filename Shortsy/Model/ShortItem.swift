//
//  ShortItem.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation
import FirebaseAuth

struct ShortItem {
    let docId: String
    let shortsId: String
    let title: String
    let url: String
    let thumbnailUrl: String
    let products: [ProductItem]
    let createdBy: String
    let createAt: Date
    let summary: String
}

extension ShortItem: Codable {
    enum CodingKeys: String, CodingKey {
        case docId
        case shortsId
        case title
        case url
        case thumbnailUrl
        case products
        case createdBy
        case createAt
        case summary
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.thumbnailUrl = (try? container.decode(String.self, forKey: .thumbnailUrl)) ?? ""
        self.products = (try? container.decode([ProductItem].self, forKey: .products)) ?? []
        self.createdBy = (try? container.decode(String.self, forKey: .createdBy)) ?? ""
        self.shortsId = (try? container.decode(String.self, forKey: .shortsId)) ?? ""
        self.url = (try? container.decode(String.self, forKey: .url)) ?? ""
        self.createAt = (try? container.decode(Date.self, forKey: .createAt)) ?? .now
        self.docId = (try? container.decode(String.self, forKey: .docId)) ?? ""
        self.summary = (try? container.decode(String.self, forKey: .summary)) ?? ""
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode(products, forKey: .products)
        try container.encode(shortsId, forKey: .shortsId)
        try container.encode(url, forKey: .url)
        try container.encode(createAt, forKey: .createAt)
        try container.encode(createdBy, forKey: .createdBy)
        try container.encode(docId, forKey: .docId)
        try container.encode(summary, forKey: .summary)
    }
}


extension ShortItem: Identifiable {
    var id: String { return docId }
}
