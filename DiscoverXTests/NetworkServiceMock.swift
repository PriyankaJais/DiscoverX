//
//  NetworkServiceMock.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 13/05/2022.
//

import Foundation
@testable import DiscoverX

class NetworkServiceMock: NetworkServiceProtocol {
    
    var fileName = ""
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchData<Model: Decodable>(url : URL?, completion: @escaping (Result<Model, ErrorResult>) -> Void) {
        guard let url = Bundle(for: NetworkServiceMock.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let dataModel = try? JSONDecoder().decode(Model.self, from: data) else {
            completion(Result.failure(.parser(string: "something went wrong")))
            return
        }
        completion(Result.success(dataModel))
    }
}

