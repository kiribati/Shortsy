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
    @Published var unparsingitems: [SharedItem] = []
    @Published var shortItem: [ShortItem] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var shortsListener: ListenerRegistration?
    
    deinit {
        shortsListener?.remove()
    }
    
    init() {
        subscribeUserDefaults()
        observeSavedData()
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
                        try $0.data(as: ShortItem.self)
                    })
                    print("shorts count = \(shorts.count)")
                    DispatchQueue.main.async {
                        self?.shortItem = shorts
                    }
                } catch {
                    print("decoding error = \(error.localizedDescription)")
                }
            }
    }
    
    func loadUnparsingedData() {
        let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
        let datas = userDefaults?.array(forKey: "SharedItems") as? [Data] ?? []
        let convertItems = datas.compactMap { SharedItem.convert($0) }
        let duduplicated = Array(Dictionary(grouping: convertItems, by: { $0.url} ))
            .compactMap({$0.value.first})
        unparsingitems = duduplicated
        
        print("savedURL count = \(datas.count), unparsingitems count = \(unparsingitems.count)")
    }
    
    private func subscribeUserDefaults() {
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: nil) { [weak self] _ in
            print("hello")
            Task {
                await self?.loadUnparsingedData()
            }
        }
    }
}

extension ListViewModel {
    func parsing(_ item: SharedItem) {
        isLoading = true
        
        Task {
            do {
                
                let savedResponse = try await FunctionsService.shared.parsingData(item.url.absoluteString)
                if savedResponse {
                    unparsingitems.removeAll(where: { $0.url == item.url })
                    let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
                    let datas = unparsingitems.compactMap{ $0.toData }
                    userDefaults?.set(datas, forKey: "SharedItems")
                }
                
                // 토큰 계산
                
            } catch {
                print(error.localizedDescription)
                showAlert = true
                alertMessage = "작업에 실패했습니다."
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
        }
    }
}
