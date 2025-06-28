//
//  ListRowView.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import SwiftUI

struct ListRowView: View {
    let item: Contents.Item
    
    var categoryColor: Color {
        switch item.category {
        case .prodeuct: return .blue
        case .cafe: return .yellow
        case .place: return .orange
        case .trip: return .purple
        default: return .pink
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: item.thumbnailURL)) { phase in
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
                
                HStack(spacing: 8) {
                    Text(item.category.text)
                        .font(.caption)
                        .foregroundColor(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(categoryColor.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Text(item.dateString.toString(format: "yyyy.MM.dd"))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
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

#Preview {
    ListRowView(item: .sample)
}
