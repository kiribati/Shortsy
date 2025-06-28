//
//  ListView.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import SwiftUI
import Combine

struct ListView: View {
    @StateObject private var viewModel: ListViewModel = ListViewModel()
    
    private let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.purple, Color.blue]),
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            gradient.ignoresSafeArea()
            VStack(spacing: 0) {
                HStack {
                    Text("Library")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        // 추가 액션
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 44)
                
                // Search Bar (Glassmorphism)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("검색", text: $viewModel.searchText)
                        .foregroundColor(.white)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal)
                .padding(.top, 8)
                
                // List
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.items) { item in
                            ListRowView(item: item)
                        }
                    }
                    .padding(.top, 24)
                    .padding(.horizontal)
                }
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ListView()
}
