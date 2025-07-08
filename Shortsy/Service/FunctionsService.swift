//
//  FunctionsService.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation

final class FunctionsService {
    static let shared = FunctionsService()
    
    private struct OpenAiBody: Encodable {
        let title: String
        let descriptionLines: [String]
    }
}

extension FunctionsService {
    func fetchScripts(_ shortsId: String) async throws -> Supadata.ResponseModel {
        let urlString = "https://fetchscript-ek5wyokbaq-uc.a.run.app"
        
        do {
            let response: FlexibleApiModel<Supadata.ResponseModel> = try await NetworkManager.shared.get(urlString, parameters: ["videoId": shortsId])
            if let data = response.data {
                return data
            }
        } catch {
            print("fetchScripts error = \(error.localizedDescription)")
        }
        
        throw FunctionsError.scriptError
    }
    
    func openAiParsing(title: String, scripts: [String]) async throws -> OpenAi.ResponseModel {
        let urlString = "https://summarizeyoutubejson-ek5wyokbaq-uc.a.run.app"
        let body = OpenAiBody(title: title, descriptionLines: scripts)
        
        do {
            let response: FlexibleApiModel<OpenAi.ResponseModel> = try await NetworkManager.shared.post(urlString, body: body)
            print("OpenAiService parsing = \(response)")
            if let data = response.data {
                return data
            }
            throw FunctionsError.parsingError
        } catch {
            print("openai parsing error = \(error.localizedDescription)")
            throw FunctionsError.parsingError
        }
    }
    
    func fetchInfo(_ shortsId: String) async throws -> Youtube.InfoModel {
        let urlString = "https://youtubeinfo-ek5wyokbaq-uc.a.run.app"
        
        do {
            let response: FlexibleApiModel<Youtube.InfoModel> = try await NetworkManager.shared.get(urlString, parameters: ["videoId": shortsId])
            if let data = response.data {
                return data
            }
        } catch {
            print("Youtube info error = \(error.localizedDescription)")
        }
        throw FunctionsError.youtubeInfoError
    }
    
    func save(_ item: ShortItem) async throws -> Bool {
        do {
            let urlString = "https://saveshorts-ek5wyokbaq-uc.a.run.app"
            let response: ApiDefaultModel = try await NetworkManager.shared.post(urlString, body: item)
            return response.result
        } catch {
            throw FunctionsError.saveError
        }
    }
}
