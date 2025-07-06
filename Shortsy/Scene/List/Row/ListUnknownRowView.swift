//
//  ListUnknownRowView.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import SwiftUI

struct ListUnknownRowView: View {
    let item: Contents.Item
    var onFetchInfo: (Contents.Item) -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.url)
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
                onFetchInfo(item)
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
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.2))
        )
    }
}

#Preview {
    ListUnknownRowView(item: .sample) { _ in }
}
