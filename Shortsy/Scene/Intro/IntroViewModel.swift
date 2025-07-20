//
//  IntroViewModel.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import Foundation
import FirebaseAuth
import Combine

final class IntroViewModel: ObservableObject {
    @Published var user: User?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func loginAnonymously() {
        AuthService.shared.signInAnonymous()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
                self?.errorMessage = nil
                
                self?.checkReward(user.uid)
            }
            .store(in: &cancellables)
    }
    
    private func firstLogin(_ userId: String) {
        Task {
            let urlString = "https://firstOpen-ek5wyokbaq-uc.a.run.app"
            let _: ApiDefaultModel? = try? await NetworkManager.shared.get(urlString, parameters: ["userId": userId])
        }
    }
    
    private func checkReward(_ userId: String) {
        Task {
            let urlString = "https://checkReward-ek5wyokbaq-uc.a.run.app"
            let _: ApiDefaultModel? = try? await NetworkManager.shared.get(urlString, parameters: ["userId": userId])
        }
    }
}
