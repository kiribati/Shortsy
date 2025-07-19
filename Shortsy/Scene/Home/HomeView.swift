//
//  HomeView.swift
//  Shortsy
//
//  Created by hongdae on 6/15/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2")
//                    Text("List")
                }
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
//                    Text("Setting")
                }
        }
        .tint(Color.white)
    }
}

#Preview {
    HomeView()
}
