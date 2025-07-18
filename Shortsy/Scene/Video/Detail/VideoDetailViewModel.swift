//
//  VideoDetailViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/13/25.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

// MARK: - ViewModel
final class VideoDetailViewModel: ObservableObject {
    @Published var item: ShortItem
    @Published var products: [ProductItem] = []
    
    private var productsListener: ListenerRegistration?
    
    deinit {
        print("VideoDetailViewModel deinit")
        productsListener?.remove()
    }
    
    init(item: ShortItem) {
        self.item = item
        
//        print(item)
        loadProducts()
    }
}

extension VideoDetailViewModel {
    func loadProducts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        productsListener?.remove()
        
        let db = Firestore.firestore()
        productsListener = db.collection("products")
            .whereField("shortsId", isEqualTo: item.shortsId)
            .whereField("createdBy", isEqualTo: uid)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener({ [weak self] snapshot, error in
                guard let documents = snapshot?.documents else { return }
                
                do {
                    let products = try documents.compactMap { try $0.data(as: ProductItem.self) }
                    print("product count = \(products.count)")
                    DispatchQueue.main.async {
                        self?.products = products
                    }
                } catch {
                    print("decoding error = \(error.localizedDescription)")
                }
            })
    }
}
