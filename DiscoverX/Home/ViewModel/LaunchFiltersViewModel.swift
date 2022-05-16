//
//  LaunchFiltersViewModel.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import Foundation

enum SortOrder {
    case ascending
    case descending
    
    var title: String {
        switch self {
        case .ascending:
            return Translations.sortByAscending
        case .descending:
            return Translations.sortByDescending
        }
    }
}

enum FilterType {
    case years
    case success
    case sortOrder
}

struct Filter: Equatable {
    let filterType: FilterType
    let filterTitle: String
}

struct LaunchFiltersViewModel {
    var years: Set<Int>
    var yearsSelected: Set<Int>?
    var sortOrder: SortOrder
    
    var filters: [Filter] {
        var filtersArray: [Filter] = []
        let successFilter = Filter(filterType: .success, filterTitle: Translations.showOnlySuccessfulLaunches)
        let sortOrderFilter = Filter(filterType: .sortOrder, filterTitle: String(sortOrder.title))
        let sortedYears = years.sorted().reversed()
        let yearFilters = sortedYears.map{
            Filter(filterType: .years, filterTitle: String($0))
        }
        filtersArray.append(successFilter)
        filtersArray.append(sortOrderFilter)
        filtersArray.append(contentsOf: yearFilters)
        return filtersArray
    }
    
    init(years: [Int], sortOrder: SortOrder = .descending) {
        self.years = Set(years)
        self.sortOrder = sortOrder
    }
}
