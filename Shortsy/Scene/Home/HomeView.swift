//
//  HomeView.swift
//  Shortsy
//
//  Created by hongdae on 6/15/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init())
    }
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                }
        }
        .tint(Color.white)
    }
}

#Preview {
    HomeView()
}
