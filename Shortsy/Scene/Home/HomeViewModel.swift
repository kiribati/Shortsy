//
//  HomeViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import Foundation
import FirebaseMessaging
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    init() {
        updateToken()
    }
}

extension HomeViewModel {
    private struct FcmUpdateBody: Encodable {
        let userId: String
        let fcmtoken: String
    }
}

extension HomeViewModel {
    func updateToken() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Messaging.messaging().token { token, error in
            Task {
                if let token, token.isNotEmpty {
                    let urlString = "https://updateFcm-ek5wyokbaq-uc.a.run.app"
                    let body = FcmUpdateBody(userId: uid, fcmtoken: token)
                    let response: ApiDefaultModel? = try? await NetworkManager.shared.post(urlString, body: body)
                }
            }
        }
    }
}
