//
//  VideoDetailViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/13/25.
//

import Foundation

// MARK: - ViewModel
final class VideoDetailViewModel: ObservableObject {
    @Published var item: ShortItem
    @Published var products: [ProductItem] = []
    
    init(item: ShortItem) {
        self.item = item
        
        print(item)
    }
}

extension VideoDetailViewModel {
    func loadProducts() {
        
    }
}
