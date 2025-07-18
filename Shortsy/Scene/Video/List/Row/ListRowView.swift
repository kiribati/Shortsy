//
//  ListRowView.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import SwiftUI

struct ListRowView: View {
    let item: ShortItem
    let onDelete: () -> Void
    @State private var showDeleteAlert = false
    
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
            
            Button(action: {
                showDeleteAlert = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Color.clear)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(
            Color.white.opacity(0.08)
                .blur(radius: 0.5)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        )
        .alert("", isPresented: $showDeleteAlert) {
            Button("Ok".localized, role: .destructive) {
                onDelete()
            }
        } message: {
            Text("delete_alert_message".localized)
        }
    }
}
