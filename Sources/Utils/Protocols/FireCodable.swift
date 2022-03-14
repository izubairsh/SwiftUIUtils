//
//  FireCodable.swift
//  ExcelApp
//
//  Created by Zubair Sheikh on 17/10/2021.
//

import UIKit

public protocol FireCodable: BaseCodable {
  var id: String { get set }
}

public protocol FireStorageCodable: FireCodable {
  var image: UIImage? { get set }
  var imageLink: String? { get set }
}
