//
//  ProductDetailViewModel.swift
//  Shortsy
//
//  Created by Brown on 7/18/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    @Published var product: ProductItem
    
    init(product: ProductItem) {
        self.product = product
    }
}
