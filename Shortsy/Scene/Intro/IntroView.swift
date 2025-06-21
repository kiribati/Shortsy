//
//  IntroView.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import SwiftUI

struct IntroView: View {
    var onFinish: () -> Void
    
    @StateObject private var viewModel = IntroViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.ignoresSafeArea()

                // 서브 타이틀
                VStack(spacing: 5) {
                    Text("Effortlessly parse YouTube links.")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                
                .padding()
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                viewModel.loginAnonymously()
            }
        }
        .onChange(of: viewModel.user, { oldValue, newValue in
            if let _ = newValue {
                print("login successed")
                onFinish()
            }
        })
        .padding()
    }
}

#Preview {
    IntroView(onFinish: { })
}
