//
//  VideoDetailView.swift
//  Shortsy
//
//  Created by hongdae on 7/12/25.
//

import SwiftUI

struct VideoDetailView: View {
//    let item: ShortItem
    @StateObject var viewModel: VideoDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    // 외부에서 video를 주입받아 ViewModel 생성
    init(item: ShortItem) {
        _viewModel = StateObject(wrappedValue: VideoDetailViewModel(item: item))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // 썸네일 이미지
                AsyncImage(url: URL(string: viewModel.item.thumbnailUrl)) { phase in
                    switch phase {
                    case .success(let img):
                        img.resizable()
                            .scaledToFill()
                            .frame(height: (UIScreen.main.bounds.width - 32) * 9 / 16)
                            .clipped()
                            .cornerRadius(16)
                    case .empty:
                        Color.gray.opacity(0.2)
                            .frame(height: (UIScreen.main.bounds.width - 32) * 9 / 16)
                            .cornerRadius(16)
                    case .failure(_):
                        Color.gray.opacity(0.1)
                            .overlay(Image(systemName: "photo").font(.largeTitle))
                            .frame(height: (UIScreen.main.bounds.width - 32) * 9 / 16)
                            .cornerRadius(16)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.top, 16)
                
                // 날짜
                Text(viewModel.item.createAt.toString(format: "yyyy-MM-dd"))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.leading, 8)
                
                // 영상 요약
                VStack(alignment: .leading, spacing: 8) {
                    Text("영상 요약")
                        .font(.headline)
                    Text(viewModel.item.title)
                        .font(.body)
                }
                .padding()
                .background(Color.white.opacity(0.13))
                .cornerRadius(12)
                .padding(.horizontal, 4)
                
                // 상품 목록
                VStack(alignment: .leading, spacing: 4) {
                    Text("상품 목록")
                        .font(.headline)
                        .padding(.bottom, 2)
                    
                    ForEach(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product)) {
                            ProductRowView(item: product)
//                                .padding()
                        }
                    }
                }
//                .padding(.horizontal, 4)
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(viewModel.item.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                     presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if let url = URL(string: viewModel.item.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
            }
        }
        .background(
            LinearGradient(colors: [Color.purple, Color.blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .toolbar(.hidden, for: .tabBar)
    }
}

// MARK: - 미리보기
//struct VideoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoDetailView()
//    }
//}
