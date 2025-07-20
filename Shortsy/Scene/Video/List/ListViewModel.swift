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
    }
    
    private func subscribeUserDefaults() {
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: nil) { [weak self] _ in
            Task {
                await self?.loadUnparsingedData()
            }
        }
    }
}

//  MARK: - Inteface
extension ListViewModel {
    func parsing(_ item: SharedItem) {
        isLoading = true
        
        Task {
            do {
                let savedResponse = try await FunctionsService.shared.parsingData(item.url.absoluteString)
                if savedResponse {
                    self.delete(item)
                }
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
    
    func delete(_ item: SharedItem) {
        unparsingitems.removeAll(where: { $0.url == item.url })
        let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
        let datas = unparsingitems.compactMap{ $0.toData }
        userDefaults?.set(datas, forKey: "SharedItems")
    }
    
    func delete(_ item: ShortItem) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("shorts")
            .document(item.docId)
            .delete()
        
        db.collection("products")
            .whereField("shortsId", isEqualTo: item.shortsId)
            .whereField("createdBy", isEqualTo: uid)
            .whereField("url", isEqualTo: item.url)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("products 삭제 쿼리 실패: \(error.localizedDescription)")
                    return
                }
                guard let documents = snapshot?.documents, !documents.isEmpty else {
                    print("products 해당 없음")
                    return
                }
                
                let group = DispatchGroup()
                for doc in documents {
                    group.enter()
                    db.collection("products").document(doc.documentID).delete { err in
                        if let err = err {
                            print("products 문서 삭제 실패: \(err.localizedDescription)")
                        }
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    print("products 컬렉션 해당 shortsId로 전부 삭제 완료")
                }
            }
    }
}
