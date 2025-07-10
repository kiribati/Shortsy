//
//  Contents.Item+.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

extension Contents {
    struct Item: Identifiable {
        let id: String
        let title: String
        let url: String
        let thumbnailUrl: String
        let date: Date
        let category: Contents.Category
        let status: Contents.Status
    }
}

extension Contents.Item {
    static var sample: Self {
        .init(
            id: "",
            title: "",
            url: "",
            thumbnailUrl: "",
            date: Date(),
            category: .unKnown,
            status: .unParsing
        )
    }
    
    static func create(_ url: String, date: Date) -> Contents.Item {
        return .init(id: "", title: "", url: url, thumbnailUrl: "", date: date, category: .unKnown, status: .unParsing)
    }
}

extension Contents.Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case url
        case thumbnailUrl
        case date = "createdAt"
        case category
        case status
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? container.decode(String.self, forKey: .id)) ?? ""
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.url = (try? container.decode(String.self, forKey: .url)) ?? ""
        self.thumbnailUrl = (try? container.decode(String.self, forKey: .thumbnailUrl)) ?? ""
        self.date = (try? container.decode(Date.self, forKey: .date)) ?? .now
        
        let categoryValue = (try? container.decode(String.self, forKey: .category)) ?? ""
        self.category = Contents.Category(rawValue: categoryValue) ?? .unKnown
        
        let statusValue = (try? container.decode(String.self, forKey: .status)) ?? ""
        self.status = Contents.Status(rawValue: statusValue) ?? .saved
    }
}

//extension Contents.Item: ListItem {
//    var createAt: Date { return date }
//    var products: [ProductItem] { return [] }
//}
