//
//  OpenAi.ResponseModel+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension OpenAi {
    struct ResponseModel {
        let title: String
        let items: [OpenAi.ContentModel]
    }
}

extension OpenAi.ResponseModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case title
        case items
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = (try? container.decode(String.self, forKey: .title)) ?? ""
        self.items = (try? container.decode([OpenAi.ContentModel].self, forKey: .items)) ?? []
    }
}
