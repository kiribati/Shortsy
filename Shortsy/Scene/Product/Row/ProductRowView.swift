//
//  ProductRowView.swift
//  Shortsy
//
//  Created by hongdae on 7/13/25.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct ProductRowView: View {
    let item: ProductItem
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 3) {
                Text(item.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                if item.price.isNotEmpty {
                    Text(item.price)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Text(item.descriptions.joined(separator: "\n"))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                if let url = URL(string: item.link) {
                    Link(destination: url) {
                        Text("구매하기")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .cornerRadius(14)
                    }
                    .padding(.top, 4)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 14)
            .padding(.horizontal, 18)
            .background(
                BlurView(style: .systemThinMaterialDark)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.18), lineWidth: 1.2)
                    )
            )
            .shadow(color: .black.opacity(0.13), radius: 9, x: 0, y: 3)
            .padding(.vertical, 2)
        }
}
