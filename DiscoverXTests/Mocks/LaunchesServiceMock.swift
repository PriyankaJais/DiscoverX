//
//  LaunchesServiceMock.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import Foundation
@testable import DiscoverX

class LaunchesServiceMock: LaunchesNetworkServiceProtocol {
    
    var fileName = ""
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchLaunches(completion: ((LaunchesFetchCompletion) -> Void)?) {
        guard let url = Bundle(for: LaunchesServiceMock.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let launches = try? JSONDecoder().decode(Launches.self, from: data) else {
            completion?(Result.failure(.parser(string: "something went wrong")))
            return
        }
        completion?(Result.success(launches))
    }
}

