//
//  NetworkService.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<Model: Decodable>(url : URL?, completion: @escaping (Result<Model, ErrorResult>) -> Void)
}

struct NetworkService: BaseNetworkService, NetworkServiceProtocol {
    
    func fetchData<Model: Decodable>(url : URL?, completion: @escaping (Result<Model, ErrorResult>) -> Void) {
        guard let fetchUrl = url else { return }
        let fetchTask = session.dataTask(with: fetchUrl, completionHandler: {data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(Result.failure(.network(error: error)))
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(Result.failure(.parser(string: Translations.emptyDataErrorMessage)))
                }
                return
            }
            do {
                let dataModel = try JSONDecoder().decode(Model.self, from: data)
                DispatchQueue.main.async {
                    completion(Result.success(dataModel))
                }
            } catch let jsonError as NSError {
                DispatchQueue.main.async {
                    completion(Result.failure(.parser(string: jsonError.localizedDescription)))
                }
            }
        })
            
        fetchTask.resume()
    }
}

