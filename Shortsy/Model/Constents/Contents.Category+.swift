//
//  Contents.Category+.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

extension Contents {
    enum Category: String {
        case product
        case place
        case cafe
        case restaurant
        case trip
        case unKnown
    }
}

extension Contents.Category {
    var text: String {
        switch self {
        case .product:
            return "category_product".localized
        case .place:
            return "category_place".localized
        case .cafe:
            return "category_cafe".localized
        case .restaurant:
            return "category_restaurant".localized
        case .trip:
            return "category_trip".localized
        case .unKnown:
            return "category_unknown".localized
        }
    }
    
    static func create(_ rawValue: String) -> Contents.Category {
        switch rawValue.lowercased() {
        case "cafe":
            return .cafe
            case "restaurant":
            return .restaurant
        case "trip":
            return .trip
        case "product":
            return .product
        case "place":
            return .place
        default:
            return .unKnown
        }
    }
}
