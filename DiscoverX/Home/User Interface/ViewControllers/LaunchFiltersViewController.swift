//
//  LaunchFiltersViewController.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 12/05/2022.
//

import Foundation
import UIKit

class LaunchFiltersViewController: UIViewController {
    
    @IBOutlet private weak var clearButton: UIButton?
    @IBOutlet private weak var launchFiltersTableView: UITableView?
    var launchFiltersViewModel: LaunchFiltersViewModel?
    var onDismiss: (([Filter], Bool) -> Void)?
    private var selectedFilters: [Filter] = []
    private var clearFilters = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onDismiss?(selectedFilters, clearFilters)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        selectedFilters.removeAll()
        clearFilters = true
        dismiss(animated: true)
    }
    
    private func setup() {
        launchFiltersTableView?.register(UINib(nibName: LaunchFiltersTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchFiltersTableViewCell.reuseIdentifier)
        clearButton?.setAttributedTitle(NSAttributedString(string: Translations.clearFiltersTitle, attributes: [.font: StyleGuide.value.font]), for: .normal)
    }
}

extension LaunchFiltersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launchFiltersViewModel?.filters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchFiltersTableViewCell.reuseIdentifier, for: indexPath) as? LaunchFiltersTableViewCell,
              let launchFilter = launchFiltersViewModel?.filters[indexPath.row] else {
            return UITableViewCell()
        }
        cell.config(filterTitle: launchFilter.filterTitle)
        return cell
    }
}

extension LaunchFiltersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LaunchFiltersTableViewCell,
              let launchFilter = launchFiltersViewModel?.filters[indexPath.row] else { return }
        updateSelectedFilters(with: launchFilter, cell: cell)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? LaunchFiltersTableViewCell,
              let launchFilter = launchFiltersViewModel?.filters[indexPath.row] else { return }
        updateSelectedFilters(with: launchFilter, cell: cell)
    }

    private func updateSelectedFilters(with filter: Filter, cell: LaunchFiltersTableViewCell) {
        cell.updateState()
        if let index = selectedFilters.firstIndex(where: { $0 == filter }) {
            selectedFilters.remove(at: index)
            return
        }
        selectedFilters.append(filter)
    }
}

