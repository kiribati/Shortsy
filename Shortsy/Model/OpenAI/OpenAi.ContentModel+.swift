//
//  OpenAi.ContentModel+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

//extension OpenAi {
//    struct ContentModel {
//        let category: Contents.Category
//        let name: String
//        let link: String
//        let price: String
//        let descriptions: [String]
//    }
//}
//
//extension OpenAi.ContentModel: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case category
//        case name
//        case link
//        case price
//        case descriptions
//    }
//    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        let categoryValue = (try? container.decode(String.self, forKey: .category)) ?? ""
//        self.category = Contents.Category.create(categoryValue)
//        
//        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
//        self.link = (try? container.decode(String.self, forKey: .link)) ?? ""
//        self.price = (try? container.decode(String.self, forKey: .price)) ?? ""
//        self.descriptions = (try? container.decode([String].self, forKey: .descriptions)) ?? []
//    }
//}
