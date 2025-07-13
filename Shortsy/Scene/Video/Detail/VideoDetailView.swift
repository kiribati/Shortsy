//
//  VideoDetailView.swift
//  Shortsy
//
//  Created by hongdae on 7/12/25.
//

import SwiftUI

struct VideoDetailView: View {
    let item: ShortItem
    @StateObject var viewModel = VideoDetailViewModel(item: item)
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // 썸네일(쇼츠 비율: 9:16)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            VStack {
                                Image("thumbnail")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 320) // 9:16 비율
                                    .clipped()
                                    .cornerRadius(16)
                                // 실제론 URL이미지면 AsyncImage 등으로 대체
                            }
                        )
                        .frame(width: 180, height: 320)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 16)
                    
                    // 날짜
                    Text("2025년 6월 30일")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.leading, 8)
                    
                    // 영상 요약
                    VStack(alignment: .leading, spacing: 8) {
                        Text("영상 요약")
                            .font(.headline)
                        Text("이 영상은 다이소 인기 수납템 35가지를 소개합니다. 깔끔한 정리 노하우와 실제 사용 후기, 추천 꿀팁까지 담았습니다.")
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
                        
                        ForEach(viewModel.products) { product in
                            NavigationLink(destination: ProductRowView(product: product)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(product.title)
                                            .font(.body).bold()
                                        Text(product.subtitle)
                                            .font(.caption).foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    .background(Color.white.opacity(0.08).cornerRadius(14))
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 4)
                }
                .padding(.horizontal)
            }
            .navigationTitle("다이소 수납템 35개 모음")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // 뒤로가기(자동) + 우측에 영상 재생 버튼
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // 유튜브 영상 재생 등 원하는 액션
                        if let url = URL(string: "https://youtu.be/f0EqoX-EZaI") {
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
}

// MARK: - 미리보기
//struct VideoDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoDetailView()
//    }
//}
