//
//  ApiDefaultModel.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation

struct ApiDefaultModel {
    let result: Bool
    let errorMessage: String
}

extension ApiDefaultModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case result
        case errorMessage
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.result = (try? container.decode(Bool.self, forKey: .result)) ?? false
        self.errorMessage = (try? container.decode(String.self, forKey: .errorMessage)) ?? ""
    }
}
