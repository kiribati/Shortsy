//
//  ProductDetailView.swift
//  Shortsy
//
//  Created by Brown on 7/18/25.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject var viewModel: ProductDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
//    let productName: String = "활성탄 냉장고 탈취제"
//    let productPrice: String = "₩5,900"
//    let productDescription: String =
//    """
//    활성탄 성분으로 빠르게 냉장고 냄새 제거 가능.
//    작고 간편한 사이즈로 공간 절약에 효과적입니다.
//    냉장고뿐 아니라 신발장 등 다양한 곳에서 사용 가능.
//    """
//    let productImageUrl: String = "https://your-product-image-url.png" // 이미지 url 교체
//    let purchaseUrl: String = "https://your-purchase-link.com"
//    let youtubeUrl: String = "https://youtube.com" // 실제 유튜브 링크
    
    init(_ item: ProductItem) {
        _viewModel = StateObject(wrappedValue: ProductDetailViewModel(product: item))
    }
    
    var body: some View {
        ZStack {
            // 그라데이션 배경
            LinearGradient(colors: [Color(hex: "A370F0"), Color(hex: "4F8CFF")], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    Spacer().frame(height: 24)
                    
                    // 카드(상품 정보)
                    VStack(spacing: 20) {
                        Text(viewModel.product.name)
                            .font(.title2.bold())
                            .foregroundStyle(Color.init(hex: "222222"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewModel.product.price)
                            .font(.title3.bold())
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider().opacity(0.2)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(viewModel.product.descriptions.joined(separator: "\n"))
                                .font(.body)
                                .foregroundStyle(Color.init(hex: "222222"))
                        }
                        
                        if let url = URL(string: viewModel.product.link) {
                            Link(destination: url) {
                                Text("구매하기")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundStyle(Color.white)
                                    .cornerRadius(14)
                            }
                            .padding(.top, 8)
                        }
                        
                    }
                    .padding(24)
                    .background(Color.white.opacity(0.94))
                    .cornerRadius(28)
                    .shadow(color: .black.opacity(0.07), radius: 5, x: 0, y: 3)
                    .padding(.horizontal, 18)
                    
                    Spacer()
                }
            }
        }
        .navigationTitle("상품 정보")
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
                Button {
                    if let url = URL(string: viewModel.product.url) {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    Image(systemName: "play.rectangle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//#Preview {
//    ProductDetailView()
//}
