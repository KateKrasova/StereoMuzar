//
//  SettingsScreen.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import SwiftUI

struct SettingsScreen: View {
    @State var isDarkMode = false
    @State var isLightThemeSelected = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.vertical)
                HStack {
                    VStack(alignment: .center) {
                        Image("lightTheme")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        
                        Button("Light Theme") {
                            isDarkMode = false
                            self.isLightThemeSelected = true
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                let window = windowScene.windows.first
                                window?.overrideUserInterfaceStyle = .light
                            }

                            UserDefaultsService.shared.saveTheme(style: .light)
                        }
                        .foregroundColor(Color("navigation"))
                        .fontWeight(isLightThemeSelected ? .bold : .regular)
                    }
                    
                    VStack(alignment: .center) {
                        Image("darkTheme")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                        
                        Button("Dark Theme") {
                            isDarkMode = true
                            self.isLightThemeSelected = false
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                let window = windowScene.windows.first
                                window?.overrideUserInterfaceStyle = .dark
                            }

                            UserDefaultsService.shared.saveTheme(style: .dark)
                        }
                        .foregroundColor(Color("navigation"))
                        .fontWeight(!isLightThemeSelected ? .bold : .regular)
                    }
                }
            }
            .onAppear {
                let theme = UserDefaultsService.shared.loadTheme()
                isDarkMode = theme == .dark
                isLightThemeSelected = theme != .dark
            }
            .navigationTitle("Choose theme")
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}



