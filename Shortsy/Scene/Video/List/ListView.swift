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
    @Environment(\.scenePhase) private var scenePhase
    
    private let gradient = LinearGradient(
        gradient: Gradient(colors: [Color.purple, Color.blue]),
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                gradient.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top Bar
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
                    
                    
//                    // Search Bar // 이건 나중에 구현
//                    HStack {
//                        Image(systemName: "magnifyingglass")
//                            .foregroundColor(.gray)
//                        TextField("검색", text: $viewModel.searchText)
//                            .foregroundColor(.white)
//                    }
//                    .padding()
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
//                    .padding(.horizontal)
//                    .padding(.top, 8)
                    
                    
                    // ScrollView with items
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            // Unparsing Items
                            LazyVStack(spacing: 20) {
                                ForEach(viewModel.unparsingitems) { item in
                                    ListUnknownRowView(item: item, onFetchInfo: {
                                        viewModel.parsing(item)
                                    }, onDelete: {
                                        viewModel.delete(item)
                                    })
                                }
                                // Parsed Items
                                LazyVStack(spacing: 20) {
                                    ForEach(viewModel.shortItem) { item in
                                        NavigationLink(destination: VideoDetailView(item: item)) {
                                            ListRowView(item: item) {
                                                viewModel.delete(item)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 24)
                        }
                        
                        Spacer()
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
            .preferredColorScheme(.dark)
        }
        .onChange(of: scenePhase) { _, newValue in
            if newValue == .active {
                viewModel.loadUnparsingedData()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(""), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
}
