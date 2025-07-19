//
//  PromptViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import Foundation

final class PromptViewModel: ObservableObject {
    @Published var inputText =  ""
    @Published var clipboardURL: String? = nil
    @Published var close: Bool = false
    @Published var isLoading = false
}

extension PromptViewModel {
    func onConfirm() {
        isLoading = true
        Task {
            let _ = try? await FunctionsService.shared.parsingData(inputText)

            await MainActor.run {
                self.isLoading = false
                self.close = true
            }
        }
    }
}
