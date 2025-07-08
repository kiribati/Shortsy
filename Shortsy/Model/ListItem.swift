//
//  ListItem.swift
//  Shortsy
//
//  Created by hongdae on 7/6/25.
//

import Foundation

protocol ListItem {
    var id: String { get }
    var title: String { get }
    var url: String { get }
    var thumbnailUrl: String { get }
    var category: Contents.Category { get }
    var products: [ProductItem] { get }
    var createAt: Date { get }
}
