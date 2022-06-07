//
//  FiltersCoordinator.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import Foundation
import UIKit

struct FiltersCoordinator: Coordinator {
    
    var onDismiss: (([Filter], Bool) -> Void)?
    private var launchesViewModel: LaunchesListViewModel
    private weak var parentViewController: UIViewController?
    
    init(rootViewController: UIViewController, launchesViewModel: LaunchesListViewModel, onDismiss: (([Filter], Bool) -> Void)?) {
        self.parentViewController = rootViewController
        self.launchesViewModel = launchesViewModel
        self.onDismiss = onDismiss
    }
    
    func start() {
        let allLaunchYears = launchesViewModel.showlaunches?.map{ $0.launchYear } ?? []
        let sortOrder: SortOrder = launchesViewModel.sortedByDescendingOrder ? .ascending : .descending
        let launchFiltersViewController = LaunchFiltersViewController()
        launchFiltersViewController.launchFiltersViewModel = LaunchFiltersViewModel(years: allLaunchYears, sortOrder: sortOrder)
        launchFiltersViewController.onDismiss = onDismiss
        parentViewController?.present(launchFiltersViewController, animated: true, completion: nil)
    }
    
}
