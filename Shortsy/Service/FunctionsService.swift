//
//  FunctionsService.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation
import FirebaseAuth

final class FunctionsService {
    static let shared = FunctionsService()
    
    private struct OpenAiBody: Encodable {
        let title: String
        let descriptionLines: [String]
        let languageCode: String
    }
    
    private struct AllInOneBody: Encodable {
        let shortsId: String
        let languageCode: String
        let url: String
        let userId: String
    }
}

extension FunctionsService {
    func parsingData(_ videoUrlString: String) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid, let shortId = YoutubeService.shortId(from: videoUrlString) else { return false }
        
        let url = "https://allinoneshorts-ek5wyokbaq-uc.a.run.app"
        let languageCode = Bundle.main.preferredLocalizations.first ?? "en"
        let body = AllInOneBody(shortsId: shortId, languageCode: languageCode, url: videoUrlString, userId: uid)
        
        let response: ApiDefaultModel = try await NetworkManager.shared.post(url, body: body)
        return response.result
    }
}
