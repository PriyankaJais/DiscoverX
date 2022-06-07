//
//  CompanyInfoViewModel.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

class CompanyInfoViewModel {
    
    var companyInfo: CompanyInfo?
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getCompanyInfo(completion: @escaping ((Bool) -> Void)) {
        networkService.fetchData(url: APIEndpoints.companyInfo().url) { [weak self] (result : Result<CompanyInfo, ErrorResult>) in
            switch result {
            case .success(let companyInfo) :
                self?.companyInfo = companyInfo
                completion(true)
            case .failure(_) :
                completion(false)
            }
        }
    }
}
