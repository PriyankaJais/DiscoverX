//
//  LaunchesListViewModel.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import Foundation

class LaunchesListViewModel {
    
    var showlaunches: Launches?
    var sortedByDescendingOrder = false
    
    private let networkService: LaunchesNetworkServiceProtocol
    private var allLaunches: Launches? {
        didSet {
            showlaunches = allLaunches
            sortedByDescendingOrder = false
        }
    }
    
    init(networkService: LaunchesNetworkServiceProtocol = LaunchesNetworkService()) {
        self.networkService = networkService
    }
    
    func getLaunches(completion: @escaping ((Bool) -> Void)) {
        networkService.fetchLaunches { [weak self] result in
            switch result {
            case .success(let launches) :
                self?.allLaunches = launches
                completion(true)
            case .failure(_) :
                completion(false)
            }
        }
    }
    
    func updateShowLaunches(filters: [Filter], clearFilters: Bool) {
        guard let showinglaunches = showlaunches else {
            return
        }
        
        if clearFilters {
            showlaunches = allLaunches
            return
        }

        var updatedLaunches: Launches = []
        var filteredBySuccess: Launches = showinglaunches
        
        if filters.contains(where: { $0.filterType == .success}) {
            filteredBySuccess = showinglaunches.filter{ $0.missionStatus }
        }
        
        let yearFilters = filters.filter{ $0.filterType == .years }
        if yearFilters.isEmpty {
            updatedLaunches = filteredBySuccess
        } else {
            yearFilters.forEach { filter in
                updatedLaunches.append(contentsOf: filteredBySuccess.filter{ $0.launchYear == (Int(filter.filterTitle) ?? 0) })
            }
        }
                
        if filters.contains(where: { $0.filterType == .sortOrder }) {
            if sortedByDescendingOrder {
                updatedLaunches.sort{ $0.launchDate < $1.launchDate }
            } else {
                updatedLaunches.sort{ $0.launchDate > $1.launchDate }
            }
            sortedByDescendingOrder = !sortedByDescendingOrder
        }
        
        self.showlaunches = updatedLaunches
    }
}
