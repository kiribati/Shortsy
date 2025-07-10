//
//  ListRowView.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import SwiftUI

struct ListRowView: View {
    let item: ShortItem
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: item.thumbnailUrl)) { phase in
                switch phase {
                case .empty: Color.gray.opacity(0.2)
                case .success(let img): img.resizable().scaledToFill()
                case .failure: Color.red
                @unknown default: Color.gray
                }
            }
            .frame(width: 60, height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                
//                HStack(spacing: 8) {
//                    item.products.forEach { product in
//                        Text(product.category.text)
//                            .font(.caption)
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 4)
//                            .background(Color.midnightBlue)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        
//                    }
//                    Text(item.createAt.toString(format: "yyyy.MM.dd"))
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    ForEach(item.products) { product in
//                        Text(product.category.text)
//                            .font(.caption)
//                            .foregroundColor(.black)
//                            .padding(.horizontal, 10)
//                            .padding(.vertical, 4)
//                            .background(Color.midnightBlue)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                        Text(item.date.toString(format: "yyyy.MM.dd"))
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }
            }
            Spacer()
        }
        .padding()
        .background(
            Color.white.opacity(0.08)
                .blur(radius: 0.5)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        )
    }
}
