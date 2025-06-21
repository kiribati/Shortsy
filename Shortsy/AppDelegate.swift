//
//  AppDelegate.swift
//  Shortsy
//
//  Created by hongdae on 6/21/25.
//

import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // 예: Firebase 초기화
        FirebaseApp.configure()
        return true
    }
}

