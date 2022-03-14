//
//  DictionaryExtension.swift
//  ExcelApp
//
//  Created by Zubair Sheikh on 17/10/2021.
//
import Foundation

extension Dictionary {
    
    public var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
