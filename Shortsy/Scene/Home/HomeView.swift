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
                    Image(systemName: "house")
                    Text("List")
                }
        }
    }
}

#Preview {
    HomeView()
}
