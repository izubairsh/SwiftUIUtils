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
            return UserDefaults.standard.string(forKey: AppKeys.language) ?? "en"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.language)
        }
    }
    public static var isAuthenticated: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppKeys.isAuthenticated)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.isAuthenticated)
        }
    }
    public static var openProfile: String {
        get {
            return UserDefaults.standard.string(forKey: AppKeys.openProfile) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.openProfile)
        }
    }
    
    public static var isTap: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppKeys.isTap)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.isTap)
        }
    }
    
    public static var username: String {
        get {
            return UserDefaults.standard.string(forKey: AppKeys.username) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.username)
        }
    }
    
    public static var userId: String {
        get {
            return UserDefaults.standard.string(forKey: AppKeys.userId) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.userId)
        }
    }
    
    public static var accessToken: String {
        get {
            return UserDefaults.standard.string(forKey: AppKeys.accessToken) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.accessToken)
        }
    }
    
    public static var refreshToken: String {
        get {
            return UserDefaults.standard.string(forKey: AppKeys.refreshToken) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.refreshToken)
        }
    }
    
    public static var latitude: Double {
        get {
            return UserDefaults.standard.double(forKey: AppKeys.latitude)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.latitude)
        }
    }
    
    public static var longitude: Double {
        get {
            return UserDefaults.standard.double(forKey: AppKeys.longitude)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.longitude)
        }
    }
    
    public static var isPro: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppKeys.isPro)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.isPro)
        }
    }
    public static var isVerified: Bool {
        get {
            return UserDefaults.standard.bool(forKey: AppKeys.isVerified)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: AppKeys.isVerified)
        }
    }
}
