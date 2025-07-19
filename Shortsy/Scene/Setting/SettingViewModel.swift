//
//  SettingViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import Foundation
import FirebaseAuth


final class SettingViewModel: ObservableObject {
    @Published var alert: AlertType? = nil
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
}

extension SettingViewModel {
    private struct LogoutBody: Encodable {
        let userId: String
    }
    
    enum AlertType: Identifiable {
        case logout(message: String, onDelete: () -> Void)
        case goodbye(message: String)
        
        var id: String {
            switch self {
            case .logout:
                return "logout"
            case .goodbye:
                return "goodbye"
            }
        }
    }
}

// MARK: - Inteface
extension SettingViewModel {
    func logout() {
        alert = .logout(message: "delete_confirm_message".localized, onDelete: { [weak self] in
            self?.delete()
        })
    }
    
    private func delete() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let url = "https://us-central1-shortsy-33dff.cloudfunctions.net/logout"
        let body = LogoutBody(userId: uid)
        
        Task {
            do {
                let response: ApiDefaultModel = try await NetworkManager.shared.post(url, body: body)
                if response.result {
                    try Auth.auth().signOut()
                    
                    await MainActor.run {
                        self.alert = .goodbye(message: "goodbye".localized)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
