//
//  DateExtensions.swift
//  Domiklik
//
//  Created by Zubair Sheikh on 16/06/2021.
//

import Foundation

extension Date{
    public var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    public func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public init(milliseconds: Double) {
        self.init(timeIntervalSince1970: milliseconds)
    }
    
}
