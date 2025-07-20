//
//  SettingViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import Foundation
import FirebaseAuth
import Combine

final class SettingViewModel: ObservableObject {
    @Published var alert: AlertType? = nil
    @Published var alarmAble: Bool? = nil
    @Published var point: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    
    init() {
        fetchAlarmAble()
        getPoint()
        $alarmAble
            .dropFirst()
            .sink { [weak self] newValue in
                if let newValue {
                    self?.updateAlarmAble(newValue)
                }
            }
            .store(in: &cancellables)
    }
}

extension SettingViewModel {
    private struct LogoutBody: Encodable {
        let userId: String
    }
    
    private struct UpdateFcm: Encodable {
        let userId: String
        let alarmAble: Bool
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

// MARK: - Log out
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

// MARK: - Push
extension SettingViewModel {
    func updateAlarmAble(_ value: Bool) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Task {
            let urlString = "https://us-central1-shortsy-33dff.cloudfunctions.net/updateFcm"
            let body = UpdateFcm(userId: userId, alarmAble: value)
            let _: ApiDefaultModel? = try? await NetworkManager.shared.post(urlString, body: body)
        }
    }
    
    private func fetchAlarmAble() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Task {
            let urlString = "https://us-central1-shortsy-33dff.cloudfunctions.net/getAlarmAble"
            let response: FlexibleApiModel<AlarmModel>? = try? await NetworkManager.shared.get(urlString, parameters: ["userId": userId])
            
            await MainActor.run {
                self.alarmAble = response?.data?.alarmAble ?? false
            }
        }
    }
}

//  MARK: - Point
extension SettingViewModel {
    private func getPoint() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Task {
            let urlString = "https://getUserPoint-ek5wyokbaq-uc.a.run.app"
            let response: FlexibleApiModel<UserPointModel>? = try? await NetworkManager.shared.get(urlString, parameters: ["userId": userId])
            if let point = response?.data?.point {
                await MainActor.run {
                    self.point = point
                }
            }
        }
    }
}
