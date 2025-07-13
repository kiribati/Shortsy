//
//  ProductRowView.swift
//  Shortsy
//
//  Created by hongdae on 7/13/25.
//

import SwiftUI

struct ProductRowView: View {
    let product: ProductItem
    
    var body: some View {
        VStack(spacing: 16) {
            Text(product.name)
                .font(.title).bold()
            Text(product.descriptions.joined(separator: ", "))
                .font(.title3)
            Spacer()
        }
        .padding()
//        .navigationTitle(product.title)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    ProductRowView()
//}
