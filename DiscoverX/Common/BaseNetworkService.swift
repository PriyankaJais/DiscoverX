//
//  BaseNetworkService.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

protocol BaseNetworkService {
    var session: URLSession { get }
}

extension BaseNetworkService {
    var session: URLSession {
        get {
            return URLSession.shared
        }
    }
}

protocol CancellationProtocol {
    func cancel()
}

extension URLSessionTask: CancellationProtocol {}
