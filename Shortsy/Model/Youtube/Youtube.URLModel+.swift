//
//  Youtube.URLModel+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension Youtube {
    struct URLModel {
        let url: String
        let width: Int
        let height: Int
    }
}

extension Youtube.URLModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.url = (try? container.decode(String.self, forKey: .url)) ?? ""
        self.width = (try? container.decode(Int.self, forKey: .width)) ?? 0
        self.height = (try? container.decode(Int.self, forKey: .height)) ?? 0
    }
}
