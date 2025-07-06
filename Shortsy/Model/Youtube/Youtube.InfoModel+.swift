//
//  Youtube.InfoModel+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension Youtube {
    struct InfoModel {
        let kind: String
        let etag: String
        let items: [Item]
        struct Item {
            let snippet: Youtube.Snippet?
        }
    }
}

extension Youtube.InfoModel.Item: Decodable {
    enum CodingKeys: String, CodingKey {
        case snippet
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.snippet = try container.decode(Youtube.Snippet.self, forKey: .snippet)
    }
}

extension Youtube.InfoModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case kind
        case etag
        case items
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.items = (try? container.decode([Youtube.InfoModel.Item].self, forKey: .items)) ?? []
        self.kind = (try? container.decode(String.self, forKey: .kind)) ?? ""
        self.etag = (try? container.decode(String.self, forKey: .etag)) ?? ""
    }
}


