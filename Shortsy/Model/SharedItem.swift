//
//  SharedItem.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

struct SharedItem {
    let url: URL
    let date: Date
}

extension SharedItem: Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case date
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(URL.self, forKey: .url)
        self.date = try container.decode(Date.self, forKey: .date)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(date, forKey: .date)
    }
}

extension SharedItem {
    var toData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
    
    static func convert(_ data: Data) -> SharedItem? {
        let decoder = JSONDecoder()
        return try? decoder.decode(SharedItem.self, from: data)
    }
}
