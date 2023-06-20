//
//  UserDefaultsService.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import UIKit

public struct UserDefaultsService {
    public enum Keys: String {
        case theme
    }

    public static let shared = UserDefaultsService()

    private init() { }

    public func saveTheme(style: UIUserInterfaceStyle) {
        UserDefaults.standard.setValue(style.rawValue, forKey: Keys.theme.rawValue)
    }

    public func loadTheme() -> UIUserInterfaceStyle {
        UIUserInterfaceStyle(rawValue: UserDefaults.standard.integer(forKey: Keys.theme.rawValue)) ?? .light
    }
}
