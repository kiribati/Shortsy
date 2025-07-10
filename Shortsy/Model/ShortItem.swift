//
//  ShortItem.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation
import FirebaseAuth

struct ShortItem {
    let shortId: String
    let title: String
    let url: String
    let thumbnailUrl: String
    let products: [ProductItem]
    let createdBy: String
    let createAt: Date
}

extension ShortItem: Codable {
    enum CodingKeys: String, CodingKey {
        case shortId = "id"
        case title
        case url
        case thumbnailUrl
        case products
        case createdBy
        case createAt
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.thumbnailUrl = (try? container.decode(String.self, forKey: .thumbnailUrl)) ?? ""
        self.products = (try? container.decode([ProductItem].self, forKey: .products)) ?? []
        self.createdBy = (try? container.decode(String.self, forKey: .createdBy)) ?? ""
        self.shortId = (try? container.decode(String.self, forKey: .shortId)) ?? ""
        self.url = (try? container.decode(String.self, forKey: .url)) ?? ""
        self.createAt = (try? container.decode(Date.self, forKey: .createAt)) ?? .now
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(thumbnailUrl, forKey: .thumbnailUrl)
        try container.encode(products, forKey: .products)
        try container.encode(shortId, forKey: .shortId)
        try container.encode(url, forKey: .url)
        try container.encode(createAt, forKey: .createAt)
    }
}

//extension ShortItem: ListItem {
//    var id: String { return shortId }
//}

extension ShortItem {
    static func create(_ data: Contents.Item) -> ShortItem {
        let uid = Auth.auth().currentUser?.uid ?? ""
        return ShortItem(shortId: data.id, title: data.title, url: data.url, thumbnailUrl: data.thumbnailUrl, products: [], createdBy: uid, createAt: data.date)
    }
}
