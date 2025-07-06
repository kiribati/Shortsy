//
//  Youtube.Thumbnail+.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

extension Youtube {
    struct Thumbnail {
        let `default`: Youtube.URLModel?
        let medium: Youtube.URLModel?
        let standard: Youtube.URLModel?
        let high: Youtube.URLModel?
        let maxres: Youtube.URLModel?
    }
}

extension Youtube.Thumbnail: Decodable {
    enum CodingKeys: String, CodingKey {
        case `default`
        case medium
        case standard
        case high
        case maxres
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.default = try? container.decode(Youtube.URLModel.self, forKey: .default)
        self.medium = try? container.decode(Youtube.URLModel.self, forKey: .medium)
        self.standard = try? container.decode(Youtube.URLModel.self, forKey: .standard)
        self.high = try? container.decode(Youtube.URLModel.self, forKey: .high)
        self.maxres = try? container.decode(Youtube.URLModel.self, forKey: .maxres)
    }
}
