//
//  UserDefaultsExtensions.swift
//  osbc
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation

extension UserDefaults {
    public static var language: String {
        get {
            return UserDefaults.standard.string(forKey: "language") ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "language")
        }
    }
    
}
