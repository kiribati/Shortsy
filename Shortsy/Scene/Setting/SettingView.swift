//
//  SettingView.swift
//  Shortsy
//
//  Created by hongdae on 7/19/25.
//

import SwiftUI

struct SettingView: View {
    @StateObject private var viewModel: SettingViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        ZStack {
            // 배경 그라데이션
            LinearGradient(colors: [Color(hex: "A370F0"), Color(hex: "4F8CFF")], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // 버전
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                        Text("Ver")
                            .foregroundStyle(Color.init(hex: "222222"))
                        Spacer()
                        Text(viewModel.appVersion)
                            .foregroundStyle(Color(hex: "222222"))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
                    .padding(.horizontal, 18)
                    
                    // 로그아웃
                    Button(action: {
                        viewModel.logout()
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .foregroundStyle(Color.red)
                            Text("logout_title")
                                .foregroundStyle(Color.red)
                                .bold()
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal, 18)
                    
                    // 약관
                    //                    NavigationLink(destination: TermsView()) {
                    //                        HStack {
                    //                            Image(systemName: "doc.plaintext")
                    //                                .foregroundColor(.purple)
                    //                            Text("약관")
                    //                            Spacer()
                    //                            Image(systemName: "chevron.right")
                    //                                .foregroundColor(.gray)
                    //                        }
                    //                        .padding()
                    //                        .background(Color.white)
                    //                        .cornerRadius(16)
                    //                        .shadow(color: .black.opacity(0.07), radius: 4, x: 0, y: 2)
                    //                    }
                    //                    .padding(.horizontal, 18)
                    
                    //                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 40)
            }
            // 네비게이션바 숨김
            .navigationBarHidden(true)
            .alert(item: $viewModel.alert) { alert in
                switch alert {
                case .logout(message: let message, onDelete: let onDelete):
                    return Alert(title: Text(""), message: Text(message), primaryButton: .destructive(Text("로그아웃"), action: onDelete), secondaryButton: .cancel())
                case .goodbye(message: let message):
                    return Alert(title: Text(""), message: Text(message), dismissButton: .default(Text("Ok".localized), action: {
                        exit(0)
                    }))
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
