//
//  Typealiases.swift
//  ExcelApp
//
//  Created by Zubair Sheikh on 17/10/2021.
//

import Foundation

public typealias EmptyCompletion = () -> Void
public typealias CompletionObject<T> = (_ response: T) -> Void
public typealias CompletionOptionalObject<T> = (_ response: T?) -> Void
public typealias CompletionResponse = (_ response: Result<Void, Error>) -> Void

