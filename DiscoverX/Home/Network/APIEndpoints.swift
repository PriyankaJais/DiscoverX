//
//  APIEndpoints.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

protocol APIEndPointProtocol {
    var pathFormat: String { get }
    var url: URL? { get }
}

enum APIBaseUrl: String {
    case api
    
    var string: String {
        switch self {
        case .api:
            return "https://api.spacexdata.com/v4"
        }
    }
}

enum APIEndpoints: APIEndPointProtocol {
    
    case companyInfo(baseUrl: APIBaseUrl = .api)
    case launches(baseUrl: APIBaseUrl = .api)
    
    var pathFormat: String {
        switch self {
        case .companyInfo:
            return "%@/company"
        case .launches:
            return "%@/launches"
        }
    }
    
    var url: URL? {
        switch self {
        case let .companyInfo(baseUrl):
            return URL(string: String(format: pathFormat, baseUrl.string))
        case let .launches(baseUrl):
            return URL(string: String(format: pathFormat, baseUrl.string))
        }
    }
}
