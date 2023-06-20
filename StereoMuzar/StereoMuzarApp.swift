//
//  StereoMuzarApp.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import SwiftUI

@main
struct StereoMuzarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let window = windowScene.windows.first
                        window?.overrideUserInterfaceStyle = UserDefaultsService.shared.loadTheme()
                    }
                }
        }
    }
}
