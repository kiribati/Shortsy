//
//  RootView.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import SwiftUI

struct RootView: View {
    @State private var isIntroShown = true
    
    var body: some View {
        Group {
            if isIntroShown {
                IntroView {
                    isIntroShown = false
                }
            } else {
                HomeView()
            }
        }
    }
}

#Preview {
    RootView()
}
