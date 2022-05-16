//
//  LaunchFiltersViewModelTests.swift
//  DiscoverXTests
//
//  Created by Priyanka Jaiswal on 16/05/2022.
//

import XCTest
@testable import DiscoverX

class LaunchFiltersViewModelTests: XCTestCase {

    func testFiltersInit() {
        let arrayOfYears = [2006, 2006, 2006, 2007, 2008, 2012, 2012, 2013, 2013, 2016]
        let launchFiltersViewModel = LaunchFiltersViewModel(years: arrayOfYears, sortOrder: .descending)
        XCTAssertEqual(launchFiltersViewModel.years.count, 6)
        XCTAssertEqual(launchFiltersViewModel.filters.count, 8)
    }

}
