//
//  ListUnknownRowView.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import SwiftUI

struct ListUnknownRowView: View {
    let item: SharedItem
    var onFetchInfo: (() -> Void)?
    let onDelete: () -> Void
    @State private var showDeleteAlert = false
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.url.absoluteString)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(item.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(action: {
                onFetchInfo?()
            }) {
                Text("fetch_info".localized)
                    .font(.callout).bold()
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(
                        Capsule()
                            .fill(Color.orange.opacity(0.92))
                    )
                    .foregroundColor(.white)
            }
            
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
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.2))
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
