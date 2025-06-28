//
//  ListViewModel.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import Foundation
import Combine

final class ListViewModel: ObservableObject {
    @Published var items: [Contents.Item] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadUnparsingedData()
        fetchData()
        // 검색 적용 (필요시)
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterVideos(query: text)
            }
            .store(in: &cancellables)
    }
    
    private func filterVideos(query: String) {
        // 실제론 전체 데이터를 따로 들고 필터하는 방식 추천
        //            fetchData()
        //            if !query.isEmpty {
        //                items = items.filter { $0.title.localizedCaseInsensitiveContains(query) }
        //            }
    }
}

//  MARK: - Fetch
extension ListViewModel {
    private func fetchData() {
        // 실제 서비스에선 Firebase/네트워크 연동으로 대체
        //        let sample = [
        //            VideoItem(thumbnailURL: "https://picsum.photos/seed/1/100/100", title: "무장임 밥을 먹는 판다", category: "맛집", dateString: "3일 전"),
        //            VideoItem(thumbnailURL: "https://picsum.photos/seed/2/100/100", title: "혁신적인 신제품 공개", category: "제품", dateString: "1주일 전"),
//            VideoItem(thumbnailURL: "https://picsum.photos/seed/3/100/100", title: "쉬운 스파게티 레시피", category: "기타", dateString: "2주 전"),
//            VideoItem(thumbnailURL: "https://picsum.photos/seed/4/100/100", title: "숨겨진 폭포를 발견하다", category: "여행", dateString: "1달 전")
//        ]
//        self.videos = sample
    }
    
    private func loadUnparsingedData() {
        let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
        let datas = userDefaults?.array(forKey: "SharedItems") as? [Data] ?? []
        let convertItems = datas.compactMap { SharedItem.convert($0) }
        var list = convertItems
            .map({ Contents.Item.create($0.url.absoluteString, date: $0.date)} )
        list.append(contentsOf: list)
        items = list
        
        print("sharedURL count = \(datas.count), items count = \(items.count)")
    }
}
