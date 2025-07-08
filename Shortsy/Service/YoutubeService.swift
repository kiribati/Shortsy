//
//  YoutubeService.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

final class YoutubeService {
//    static let shared = YoutubeService()
}

extension YoutubeService {
    static func shortId(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }
        
        let path = url.path()
        return path.hasPrefix("/") ? String(path.dropFirst()) : path
    }
}
