//
//  CompanyInfoViewModel.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

class CompanyInfoViewModel {
    
    var companyInfo: CompanyInfo?
    
    private let networkService: CompanyInfoNetworkServiceProtocol
    
    init(networkService: CompanyInfoNetworkServiceProtocol = CompanyInfoNetworkService()) {
        self.networkService = networkService
    }
    
    func getCompanyInfo(completion: @escaping ((Bool) -> Void)) {
        networkService.fetchCompanyInfo { [weak self] result in
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
