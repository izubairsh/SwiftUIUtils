//
//  LinksManager.swift
//  osbc
//
//  Created by Zubair Sheikh on 30/06/2021.
//

import Foundation
import SwiftUI

public class LinksManager {
    public static let shared: LinksManager = LinksManager()
    
    public func openURL(iOSURL: URL?, webURL: URL?) {
        if let iOSURL = iOSURL {
            if UIApplication.shared.canOpenURL(iOSURL) {
                UIApplication.shared.open(iOSURL)
            }else if let webURL = webURL{
                if UIApplication.shared.canOpenURL(webURL) {
                    UIApplication.shared.open(webURL)
                }
            }
        } else if let webURL = webURL{
            if UIApplication.shared.canOpenURL(webURL) {
                UIApplication.shared.open(webURL)
            }
        }
    }
}
