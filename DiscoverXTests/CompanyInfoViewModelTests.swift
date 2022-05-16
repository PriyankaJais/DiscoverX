//
//  CompanyInfoViewModelTests.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 13/05/2022.
//

import XCTest
@testable import DiscoverX

class CompanyInfoViewModelTests: XCTestCase {
    
    var mockedNetworkService: CompanyInfoServiceMock!
    var companyInfoViewModel: CompanyInfoViewModel!
    
    override func tearDown() {
        mockedNetworkService = nil
        super.tearDown()
    }
    
    func testSuccessCase() {
        let successTestExpectation = expectation(description: "Successful Response Test Expectation")
        mockedNetworkService = CompanyInfoServiceMock(fileName: "company-info-response")
        companyInfoViewModel = CompanyInfoViewModel(networkService: mockedNetworkService)
        companyInfoViewModel.getCompanyInfo { success in
            successTestExpectation.fulfill()
            XCTAssertTrue(success, "Response should have been decoded successfully")
            XCTAssertEqual(self.companyInfoViewModel.companyInfo?.name, "SpaceX" , "Company name should be SpaceX")
        }
        waitForExpectations(timeout: 0.1)
        
    }
    
    func testFailureCase() {
        let failureTestExpectation = expectation(description: "Failed Response Test Expectation")
        mockedNetworkService = CompanyInfoServiceMock(fileName: "company-info-incorrect-response")
        companyInfoViewModel = CompanyInfoViewModel(networkService: mockedNetworkService)
        companyInfoViewModel.getCompanyInfo { success in
            failureTestExpectation.fulfill()
            XCTAssertFalse(success, "Response should not have been decoded successfully")
        }
        waitForExpectations(timeout: 0.1)
        
    }
}
