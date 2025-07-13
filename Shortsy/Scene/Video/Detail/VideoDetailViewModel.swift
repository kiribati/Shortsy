//
//  VideoDetailViewModel.swift
//  Shortsy
//
//  Created by hongdae on 7/13/25.
//

import Foundation

// MARK: - ViewModel
final class VideoDetailViewModel: ObservableObject {
//    @Published var products: [Product] = [
//        Product(title: "3단 슬림 트롤리", subtitle: "좁은 공간 정리 트롤리"),
//        Product(title: "수납박스(대)", subtitle: "대용량 다용도 박스"),
//        Product(title: "대쉬 수납 바스켓", subtitle: "손잡이형 수납 바구니"),
//        Product(title: "투명 서랍 정리함", subtitle: "소품 정리용 투명 서랍"),
//        Product(title: "접이식 옷걸이", subtitle: "공간 절약형 접이식 걸이")
    
//    ]
    // 기타 데이터도 여기에 (예: 썸네일URL, 요약 등)
    
    let item: ShortItem
    
    init(item: ShortItem) {
        self.item = item
    }
}
