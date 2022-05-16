//
//  ErrorResult.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

enum ErrorResult: Error {
    case parser(string: String)
    case network(error: Error?)
}
