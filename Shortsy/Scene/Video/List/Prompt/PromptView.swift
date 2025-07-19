//
//  PromptView.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import SwiftUI

struct PromptView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PromptViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                Text("URL을 입력하세요")
                    .font(.headline)
                TextField("여기에 URL을 입력", text: $viewModel.inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.URL)
                    .padding(.horizontal)
                // 클립보드에 URL이 있으면 붙여넣기 버튼
                if let url = viewModel.clipboardURL {
                    Button("클립보드에서 붙여넣기") {
                        viewModel.inputText = url
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(12)
                }
                HStack {
                    Button("Cancel".localized) {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                    Button("Ok".localized) {
                        viewModel.onConfirm()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(viewModel.inputText.isEmpty)
                }
                .padding(.horizontal)
            }
            .padding()
            .presentationDragIndicator(.visible)
            .onChange(of: viewModel.close) { _, newValue in
                if newValue {
                    dismiss()
                }
            }
            
            // 로딩 뷰 (ZStack 맨 위)
            if viewModel.isLoading {
                Color.black.opacity(0.05)
                    .ignoresSafeArea()
                    .allowsHitTesting(true)
                
                LoadingIndicatorView()
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    PromptView()
}
