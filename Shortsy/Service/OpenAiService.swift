//
//  OpenAiService.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import Foundation

final class OpenAiService {
    static let shared = OpenAiService()
    
    struct Body: Encodable {
        let title: String
        let descriptionLines: [String]
    }
}

extension OpenAiService {
    func parsing(title: String, scripts: [String]) async throws -> OpenAi.ResponseModel {
        let urlString = "https://summarizeyoutubejson-ek5wyokbaq-uc.a.run.app"
        let body = Body(title: title, descriptionLines: scripts)
        do {
            let response: FlexibleApiModel<OpenAi.ResponseModel> = try await NetworkManager.shared.post(urlString, body: body)
            print("OpenAiService parsing = \(response)")
            if let data = response.data {
                return data
            }
            throw OpenAIError.parsingError
        } catch {
            print("openai parsing error = \(error.localizedDescription)")
            throw OpenAIError.parsingError
        }
    }
}
