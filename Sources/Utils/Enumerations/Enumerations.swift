//
//  Enumerations.swift
//  osbc
//
//  Created by Zubair Sheikh on 15/06/2021.
//

import Foundation
import SwiftUI

public enum RecordType {
    case text, url
}

public enum FieldType{
    case email, username, password, fullname
    
    public func getRegix() -> String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        case .username:
            return "^[a-zA-Z0-9_.-]*$"
        case .password:
            return "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
        default:
            return ""
        }
    }
}

public enum ActiveSheet: Identifiable {
    case first, second
    
    public var id: Int {
        hashValue
    }
}

public enum MenuSelection: Identifiable {
    case one, two, three, four, five ,six, seven, eight
    
    public var id: Int {
        hashValue
    }
}

public enum SwipeHVDirection: String {
    case left, right, up, down, none
}


public func detectDirection(value: DragGesture.Value) -> SwipeHVDirection {
    if value.startLocation.x < value.location.x - 24 {
        return .left
    }
    if value.startLocation.x > value.location.x + 24 {
        return .right
    }
    if value.startLocation.y < value.location.y - 24 {
        return .down
    }
    if value.startLocation.y > value.location.y + 24 {
        return .up
    }
    return .none
}

