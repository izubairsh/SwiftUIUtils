//
//  EncodableExtension.swift
//  ExcelApp
//
//  Created by Zubair Sheikh on 17/10/2021.
//

import Foundation

extension Encodable {
    public var values: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
