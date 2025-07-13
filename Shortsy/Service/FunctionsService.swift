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

//extension FunctionsService {
//    func fetchScripts(_ shortsId: String) async throws -> Supadata.ResponseModel {
//        let urlString = "https://fetchscript-ek5wyokbaq-uc.a.run.app"
//        
//        do {
//            let response: FlexibleApiModel<Supadata.ResponseModel> = try await NetworkManager.shared.get(urlString, parameters: ["videoId": shortsId])
//            if let data = response.data {
//                return data
//            } else {
//                print("fetchScripts response error = \(response.errorMessage)")
//            }
//        } catch {
//            print("fetchScripts error = \(error.localizedDescription)")
//        }
//        
//        throw FunctionsError.scriptError
//    }
//    
//    func openAiParsing(title: String, scripts: [String]) async throws -> OpenAi.ResponseModel {
//        let urlString = "https://summarizeyoutubejson-ek5wyokbaq-uc.a.run.app"
//        let languageCode = Bundle.main.preferredLocalizations.first ?? "en"
//        let body = OpenAiBody(title: title, descriptionLines: scripts, languageCode: languageCode)
//        
//        do {
//            let response: FlexibleApiModel<OpenAi.ResponseModel> = try await NetworkManager.shared.post(urlString, body: body)
//            print("OpenAiService parsing = \(response)")
//            if let data = response.data {
//                return data
//            } else {
//                print("openAiParsing response error = \(response.errorMessage)")
//            }
//            throw FunctionsError.parsingError
//        } catch {
//            print("openai parsing error = \(error.localizedDescription)")
//            throw FunctionsError.parsingError
//        }
//    }
//    
//    func fetchInfo(_ shortsId: String) async throws -> Youtube.InfoModel {
//        let urlString = "https://youtubeinfo-ek5wyokbaq-uc.a.run.app"
//        
//        do {
//            let response: FlexibleApiModel<Youtube.InfoModel> = try await NetworkManager.shared.get(urlString, parameters: ["videoId": shortsId])
//            if let data = response.data {
//                return data
//            } else {
//                print("fetchInfo response error = \(response.errorMessage)")
//            }
//        } catch {
//            print("Youtube info error = \(error.localizedDescription)")
//        }
//        throw FunctionsError.youtubeInfoError
//    }
//    
//    func save(_ item: StoreSaveItem) async throws -> Bool {
//        do {
//            let urlString = "https://saveshorts-ek5wyokbaq-uc.a.run.app"
//            let response: ApiDefaultModel = try await NetworkManager.shared.post(urlString, body: item)
//            return response.result
//        } catch {
//            throw FunctionsError.saveError
//        }
//    }
//}

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
