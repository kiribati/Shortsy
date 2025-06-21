//
//  ShortsyApp.swift
//  Shortsy
//
//  Created by hongdae on 6/15/25.
//

import SwiftUI

@main
struct ShortsyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            HomeView()
//            IntroView()
            RootView()
        }
    }
}
