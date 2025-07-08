//
//  ProductItem.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation

struct ProductItem {
    let name: String
    let price: String
    let link: String
    let descriptions: [String]
}

extension ProductItem: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case price
        case link
        case descriptions
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.price = try container.decode(String.self, forKey: .price)
        self.link = try container.decode(String.self, forKey: .link)
        self.descriptions = try container.decode([String].self, forKey: .descriptions)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(link, forKey: .link)
        try container.encode(descriptions, forKey: .descriptions)
    }
}
