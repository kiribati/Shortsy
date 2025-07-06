//
//  ListViewModel.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class ListViewModel: ObservableObject {
    @Published var unparsingitems: [Contents.Item] = []
    @Published var storeItems: [Contents.Item] = []
    
    @Published var items: [Contents.Item] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private var shortsListener: ListenerRegistration?
    
    deinit {
        shortsListener?.remove()
    }
    
    init() {
        loadUnparsingedData()
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
    func observeSavedData() {
        // 실제 서비스에선 Firebase/네트워크 연동으로 대체
        //        let sample = [
        //            VideoItem(thumbnailURL: "https://picsum.photos/seed/1/100/100", title: "무장임 밥을 먹는 판다", category: "맛집", dateString: "3일 전"),
        //            VideoItem(thumbnailURL: "https://picsum.photos/seed/2/100/100", title: "혁신적인 신제품 공개", category: "제품", dateString: "1주일 전"),
//            VideoItem(thumbnailURL: "https://picsum.photos/seed/3/100/100", title: "쉬운 스파게티 레시피", category: "기타", dateString: "2주 전"),
//            VideoItem(thumbnailURL: "https://picsum.photos/seed/4/100/100", title: "숨겨진 폭포를 발견하다", category: "여행", dateString: "1달 전")
//        ]
//        self.videos = sample
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        shortsListener?.remove()
        
        
        let db = Firestore.firestore()
        shortsListener = db.collection("shorts")
            .whereField("createdBy", isEqualTo: uid)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener{ [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("observeSavedData error = \(String(describing: error?.localizedDescription))")
                    return
                }
                
                do {
                    let shorts = try documents.compactMap({
                        try $0.data(as: Contents.Item.self)
                    })
                    DispatchQueue.main.async {
                        self?.storeItems = shorts
                    }
                } catch {
                    print("decoding error = \(error.localizedDescription)")
                }
            }
    }
    
    private func loadUnparsingedData() {
        let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
        let datas = userDefaults?.array(forKey: "SharedItems") as? [Data] ?? []
        let convertItems = datas.compactMap { SharedItem.convert($0) }
        let list = convertItems
            .map({ Contents.Item.create($0.url.absoluteString, date: $0.date)} )
        let duduplicated = Array(Dictionary(grouping: list, by: { $0.url} ))
            .compactMap({$0.value.first})
        items = duduplicated
        
        print("sharedURL count = \(datas.count), items count = \(items.count)")
    }
}

//  MARK: - Public
extension ListViewModel {
    func parsing(_ item: Contents.Item) {
        isLoading = true
        Task {
            do {
                // 유튜브 정보
                let youtubeInfo = try await YoutubeService.shared.fetchInfo(item.url)
                print("youtubeInfo: \(String(describing: youtubeInfo))")
                guard let firstInfo = youtubeInfo?.items.first?.snippet else {
                    throw YoutubeError.notfound
                }
                
                // openai 파싱
                let openAiResponse = try await OpenAiService.shared.parsing(title: firstInfo.title, scripts: [firstInfo.description])
                print("openAiResponse = \(openAiResponse)")
                
                // firebase store 업데이트
                let savedResponse = try await
                
                // 토큰 계산
                
                // 리스트 업데이트
                
            } catch YoutubeError.scriptError {
                print("YoutubeError.scriptError")
            } catch YoutubeError.notfound {
                print("YoutubeError.notfound")
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
}
