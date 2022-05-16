//
//  CompanyInfoNetworkService.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

import Foundation

typealias CompanyInfoFetchCompletion = (Result<CompanyInfo, ErrorResult>)

protocol CompanyInfoNetworkServiceProtocol {
    func fetchCompanyInfo(completion: ((CompanyInfoFetchCompletion) -> Void)?)
}

struct CompanyInfoNetworkService: BaseNetworkService, CompanyInfoNetworkServiceProtocol {
    
    func fetchCompanyInfo(completion: ((CompanyInfoFetchCompletion) -> Void)? = nil) {
        guard let companyInfoUrl = APIEndpoints.companyInfo().url else { return }
        let fetchTask = session.dataTask(with: companyInfoUrl, completionHandler: {data, response, error in
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
                let companyInfo = try JSONDecoder().decode(CompanyInfo.self, from: data)
                DispatchQueue.main.async {
                    completion?(Result.success(companyInfo))
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

