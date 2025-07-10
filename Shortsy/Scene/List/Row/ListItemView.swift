//
//  ListItemView.swift
//  Shortsy
//
//  Created by Brown on 7/9/25.
//

import SwiftUI

//// 아이템 렌더링 분리
//struct ListItemView: View {
//    let item: ListItem
//    let parsingAction: (ListItem) -> Void
//    var body: some View {
//        Group {
//            if item.status == .unParsing {
//                ListUnknownRowView(item: item, onFetchInfo: parsingAction)
//            } else {
//                ListRowView(item: item)
//            }
//        }
//    }
//}
//
//#Preview {
//    ListItemView(item: .sample, parsingAction: { _ in })
//}
