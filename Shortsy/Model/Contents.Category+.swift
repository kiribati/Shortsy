//
//  Contents.Category+.swift
//  Shortsy
//
//  Created by hongdae on 6/28/25.
//

import Foundation

extension Contents {
    enum Category {
        case prodeuct
        case place
        case cafe
        case restaurant
        case trip
    }
}

extension Contents.Category {
    var text: String {
        switch self {
        case .prodeuct:
            return "상품"
        case .place:
            return "장소"
        case .cafe:
            return "카페"
        case .restaurant:
            return "레스토랑"
        case .trip:
            return "여행"
        }
    }
}
