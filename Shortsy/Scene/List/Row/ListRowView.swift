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
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
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
