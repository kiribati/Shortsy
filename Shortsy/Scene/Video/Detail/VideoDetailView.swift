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
                // 썸네일 (쇼츠 비율)
                Image(viewModel.item.thumbnailUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 320)
                    .clipped()
                    .cornerRadius(16)
                    .frame(maxWidth: .infinity)
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
                VStack(alignment: .leading, spacing: 8) {
                    Text("상품 목록")
                        .font(.headline)
                        .padding(.bottom, 2)
                    
                    //                        ForEach(viewModel.item.products) { product in
                    //                            NavigationLink(destination: ProductDetailView(product: product)) {
                    //                                HStack {
                    //                                    VStack(alignment: .leading, spacing: 2) {
                    //                                        Text(product.title)
                    //                                            .font(.body).bold()
                    //                                        Text(product.subtitle)
                    //                                            .font(.caption).foregroundColor(.gray)
                    //                                    }
                    //                                    Spacer()
                    //                                    Image(systemName: "chevron.right")
                    //                                        .foregroundColor(.gray)
                    //                                }
                    //                                .padding()
                    //                                .background(RoundedRectangle(cornerRadius: 14)
                    //                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    //                                    .background(Color.white.opacity(0.08).cornerRadius(14))
                    //                                )
                    //                            }
                    //                        }
                }
                .padding(.horizontal, 4)
            }
            .padding(.horizontal)
        }
        .navigationTitle(viewModel.item.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if let url = URL(string: viewModel.item.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Image(systemName: "play.rectangle.fill")
                        .font(.title2)
                }
            }
        }
        .background(
            LinearGradient(colors: [Color.purple, Color.blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

// MARK: - 미리보기
//struct VideoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoDetailView()
//    }
//}
