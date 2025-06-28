//
//  ShareViewController.swift
//  ShortsShareExtension
//
//  Created by hongdae on 6/28/25.
//

import UIKit
import Social

final class ShareViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    //
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//    
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleShare()
        imageView.layer.cornerRadius = 4
        containerView.layer.cornerRadius = 8
    }
    
    func handleShare() {
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first else { return }
        
        // public.url or public.plain-text
        if itemProvider.hasItemConformingToTypeIdentifier("public.url") {
            itemProvider.loadItem(forTypeIdentifier: "public.url", options: nil) { item, error in
                if let url = item as? URL {
                    self.saveSharedURL(url)
                }
            }
        } else if itemProvider.hasItemConformingToTypeIdentifier("public.plain-text") {
            itemProvider.loadItem(forTypeIdentifier: "public.plain-text", options: nil) { item, error in
                if let text = item as? String, let url = URL(string: text) {
                    self.saveSharedURL(url)
                }
            }
        }
    }
    
    func saveSharedURL(_ url: URL) {
        // App Group을 통한 데이터 저장 (UserDefaults or 파일)
        let item = SharedItem(url: url, date: .now)
        
        let userDefaults = UserDefaults(suiteName: Constants.Key.appGroup)
        var sharedURLs = (userDefaults?.array(forKey: "SharedItems") ?? []).compactMap { $0 as? Data }
        
        if let data = item.toData {
            sharedURLs.append(data)
            userDefaults?.set(sharedURLs, forKey: "SharedItems")
            userDefaults?.synchronize()
        }
        print("saveSharedURL = \(url.absoluteString)")
        
        // 종료
        DispatchQueue.main.async {
            self.statusLabel.text = "extension_savedone".localized
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            }
        }
    }
}
