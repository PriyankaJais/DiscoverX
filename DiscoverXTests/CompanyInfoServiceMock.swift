//
//  CompanyInfoServiceMock.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 13/05/2022.
//

import Foundation
@testable import DiscoverX

class CompanyInfoServiceMock: CompanyInfoNetworkServiceProtocol {
    
    var fileName = ""
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func fetchCompanyInfo(completion: ((CompanyInfoFetchCompletion) -> Void)?) {
        guard let url = Bundle(for: CompanyInfoServiceMock.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let companyInfo = try? JSONDecoder().decode(CompanyInfo.self, from: data) else {
            completion?(Result.failure(.parser(string: "something went wrong")))
            return
        }
        completion?(Result.success(companyInfo))
    }
}

