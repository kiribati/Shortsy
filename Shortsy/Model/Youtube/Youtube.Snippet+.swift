//
//  Youtube.Snippet+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension Youtube {
    struct Snippet {
        let title: String
        let description: String
        let thumbnails: Youtube.Thumbnail?
        let defaultLanguage: Supadata.Lang?
    }
}

extension Youtube.Snippet: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case thumbnails
        case defaultLanguage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.description = (try? container.decode(String.self, forKey: .description)) ?? ""
        self.thumbnails = try? container.decode(Youtube.Thumbnail.self, forKey: .thumbnails)
        self.defaultLanguage = Supadata.Lang(rawValue: (try? container.decode(String.self, forKey: .defaultLanguage)) ?? "")
    }
}
