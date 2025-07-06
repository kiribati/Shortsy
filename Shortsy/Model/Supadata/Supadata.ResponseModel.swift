//
//  Supadata.ResponseModel.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension Supadata {
    struct ResponseModel {
        let lang: Supadata.Lang
        let availableLangs: [Supadata.Lang]
        let content: [Content]
        
        struct Content {
            let lang: Supadata.Lang
            let text: String
            let offset: Int
            let duration: Int
        }
    }
}

extension Supadata.ResponseModel.Content: Decodable {
    enum CodingKeys: String, CodingKey {
        case lang
        case text
        case offset
        case duration
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let langValue = (try? container.decode(String.self, forKey: .lang)) ?? ""
        self.lang = Supadata.Lang(rawValue: langValue) ?? .en
        
        self.text = (try? container.decode(String.self, forKey: .text)) ?? ""
        self.offset = (try? container.decode(Int.self, forKey: .offset)) ?? 0
        self.duration = (try? container.decode(Int.self, forKey: .duration)) ?? 0
    }
}

extension Supadata.ResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case lang
        case availableLangs
        case content
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let langValue = (try? container.decode(String.self, forKey: .lang)) ?? ""
        self.lang = Supadata.Lang(rawValue: langValue) ?? .en
        
        let availableLangsValue = (try? container.decode([String].self, forKey: .availableLangs)) ?? []
        self.availableLangs = availableLangsValue.compactMap({ Supadata.Lang(rawValue: $0)})
        
        self.content = (try? container.decode([Supadata.ResponseModel.Content].self, forKey: .content)) ?? []
    }
}
