//
//  YoutubeService.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

final class YoutubeService {
    static let shared = YoutubeService()
}

extension YoutubeService {
    private func path(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }
        
        let path = url.path()
        return path.hasPrefix("/") ? String(path.dropFirst()) : path
    }
    
    func fetchInfo(_ link: String) async throws -> Youtube.InfoModel? {
        guard let id = path(from: link) else { return nil }
        
        let urlString = "https://youtubeinfo-ek5wyokbaq-uc.a.run.app?videoId=\(id)"
//        let urlString = "https://www.googleapis.com/youtube/v3/videos?part=snipped&id=\(id)&key=\(Constants.Key.youtubeKey)"
        do {
            let response: Youtube.InfoModel = try await NetworkManager.shared.get(urlString)
            return response
        } catch {
            print("YoutubeService parssing network error = \(error.localizedDescription)")
            throw YoutubeError.scriptError
        }
    }
}
