//
//  LaunchListViewModelTests.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import XCTest
@testable import DiscoverX

class LaunchListViewModelTests: XCTestCase {

    var mockedLaunchesNetworkService: NetworkServiceProtocol!
    var launchesViewModel: LaunchesListViewModel!

    override func tearDown() {
        mockedLaunchesNetworkService = nil
        super.tearDown()
    }
    
    func testSuccessCase() {
        let successTestExpectation = expectation(description: "Successful Response Test Expectation")
        mockedLaunchesNetworkService = NetworkServiceMock(fileName: "launches-response")
        launchesViewModel = LaunchesListViewModel(networkService: mockedLaunchesNetworkService)
        launchesViewModel.getLaunches { success in
            successTestExpectation.fulfill()
            XCTAssertTrue(success, "Response should have been decoded successfully")
            XCTAssertEqual(self.launchesViewModel.showlaunches?.count, 4, "Response should have been decoded to 4 items")
        }
        waitForExpectations(timeout: 0.1)

    }
    
    func testFailureCase() {
        let failureTestExpectation = expectation(description: "Failed Response Test Expectation")
        mockedLaunchesNetworkService = NetworkServiceMock(fileName: "launches-incorrect-response")
        launchesViewModel = LaunchesListViewModel(networkService: mockedLaunchesNetworkService)
        launchesViewModel.getLaunches { success in
            failureTestExpectation.fulfill()
            XCTAssertFalse(success, "Response should not have been decoded successfully")
        }
        waitForExpectations(timeout: 0.1)

    }
    
    func testFiltering() {
        let successTestExpectation = expectation(description: "Successful Response Test Expectation")
        mockedLaunchesNetworkService = NetworkServiceMock(fileName: "launches-response")
        launchesViewModel = LaunchesListViewModel(networkService: mockedLaunchesNetworkService)
        let successFilter = Filter(filterType: .success, filterTitle: "Test Filter")
        var mixedFilters = [Filter(filterType: .years, filterTitle: "2018"), Filter(filterType: .years, filterTitle: "2006")]
        launchesViewModel.getLaunches { success in
            successTestExpectation.fulfill()
            self.launchesViewModel.updateShowLaunches(filters: [successFilter], clearFilters: false)
            XCTAssertEqual(self.launchesViewModel.showlaunches?.count, 2, "Number of launches should be 2 on applying successFilter")
            self.launchesViewModel.updateShowLaunches(filters: [], clearFilters: true)
            XCTAssertEqual(self.launchesViewModel.showlaunches?.count, 4, "Number of launches should be 2 on clearing filters")
            self.launchesViewModel.updateShowLaunches(filters: mixedFilters, clearFilters: false)
            XCTAssertEqual(self.launchesViewModel.showlaunches?.count, 2, "Number of launches should be 2 on applying years filters")
            self.launchesViewModel.updateShowLaunches(filters: [], clearFilters: true)
            mixedFilters.append(successFilter)
            self.launchesViewModel.updateShowLaunches(filters: mixedFilters, clearFilters: false)
            XCTAssertEqual(self.launchesViewModel.showlaunches?.count, 1, "Number of launches should be 1 on applying mixed filters")
        }
        waitForExpectations(timeout: 0.1)
    }

}
