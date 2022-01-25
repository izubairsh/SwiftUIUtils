//
//  BaseCodable.swift
//  
//
//  Created by Zubair Sheikh on 17/01/2022.
//

import Foundation

public protocol BaseCodable: Codable, Equatable {
  var id: String? { get set }
}
