//
//  LaunchesNetworkService.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

typealias LaunchesFetchCompletion = (Result<Launches, ErrorResult>)

protocol LaunchesNetworkServiceProtocol {
    func fetchLaunches(completion: ((LaunchesFetchCompletion) -> Void)?)
}

struct LaunchesNetworkService: BaseNetworkService, LaunchesNetworkServiceProtocol {
    
    func fetchLaunches(completion: ((LaunchesFetchCompletion) -> Void)? = nil) {
        guard let launchesUrl = APIEndpoints.launches().url else { return }
        let fetchTask = session.dataTask(with: launchesUrl, completionHandler: {data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion?(Result.failure(.network(error: error)))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(Result.failure(.parser(string: Translations.emptyDataErrorMessage)))
                }
                return
            }
            do {
                let launches = try JSONDecoder().decode(Launches.self, from: data)
                DispatchQueue.main.async {
                    completion?(Result.success(launches))
                }
            } catch let jsonError as NSError {
                DispatchQueue.main.async {
                    completion?(Result.failure(.parser(string: jsonError.localizedDescription)))
                }
            }
        })
            
        fetchTask.resume()
    }
}
