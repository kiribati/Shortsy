//
//  ProductItem.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation

struct ProductItem {
    let category: Contents.Category
    let name: String
    let price: String
    let link: String
    let descriptions: [String]
    let shortId: String
    let createdAt: Date
    let url: String
}

extension ProductItem: Codable {
    enum CodingKeys: String, CodingKey {
        case category
        case name
        case price
        case link
        case descriptions
        case shortId
        case createdAt
        case url
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.price = (try? container.decode(String.self, forKey: .price)) ?? ""
        self.link = (try? container.decode(String.self, forKey: .link)) ?? ""
        self.descriptions = (try? container.decode([String].self, forKey: .descriptions)) ?? []
        let categoryValue = (try? container.decode(String.self, forKey: .category)) ?? ""
        self.category = Contents.Category.create(categoryValue)
        self.createdAt = (try? container.decode(Date.self, forKey: .createdAt)) ?? .now
        self.url = (try? container.decode(String.self, forKey: .url)) ?? ""
        self.shortId = (try? container.decode(String.self, forKey: .shortId)) ?? ""
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(link, forKey: .link)
        try container.encode(descriptions, forKey: .descriptions)
        try container.encode(category.rawValue, forKey: .category)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(url, forKey: .url)
    }
}

extension ProductItem: Identifiable {
    var id: String { UUID().uuidString }
}
