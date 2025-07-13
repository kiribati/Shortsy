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
        guard let url = URL(string: urlString), let lastEelement = url.path().split(separator: "/").last else { return nil }
        
        let path = String(lastEelement)
        return path.hasPrefix("/") ? String(path.dropFirst()) : path
    }
}
