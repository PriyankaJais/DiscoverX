//
//  HomeViewController.swift
//  DiscoverX
//
//  Created by Priyanka Jaiswal on 10/05/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private var errorLabel: UILabel?
    @IBOutlet private weak var launchListTableView: UITableView?
    private let launchesViewModel = LaunchesListViewModel()
    private let companyInfoViewModel = CompanyInfoViewModel()
    private var headerView: LaunchListTableHeaderView?
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
        fetchData()
    }
    
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showFilters))
    }
    
    private func setup() {
        title = Translations.homeTitle
        launchListTableView?.register(UINib(nibName: LaunchListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: LaunchListTableViewCell.reuseIdentifier)
        headerView = LaunchListTableHeaderView(frame: CGRect(x: 0,
                                                             y: 0,
                                                             width: launchListTableView?.frame.width ?? 0,
                                                             height: 200.0))
        launchListTableView?.tableHeaderView = headerView
        refreshControl.attributedTitle = NSAttributedString(string: Translations.pullToRefresh, attributes: [.font: StyleGuide.value.font])
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        launchListTableView?.addSubview(refreshControl)
    }
    
    private func fetchData() {
        launchesViewModel.getLaunches{ [weak self] success in
            if success {
                self?.launchListTableView?.reloadData()
            } else {
                self?.showError()
            }
        }
        
        companyInfoViewModel.getCompanyInfo { [weak self] success in
            if success {
                self?.headerView?.config(companyInfo: self?.companyInfoViewModel.companyInfo)
            } else {
                self?.launchListTableView?.tableHeaderView = UIView()
            }
        }
    }

    private func showError() {
        errorLabel?.attributedText = NSAttributedString(string: Translations.errorMessage, attributes: [.font: StyleGuide.title.font])
        errorLabel?.isHidden = false
    }
    
    private func updateList(filters: [Filter], clearFilters: Bool) {
        launchesViewModel.updateShowLaunches(filters: filters, clearFilters: clearFilters)
        launchListTableView?.reloadData()
        launchListTableView?.scrollToRow(at: IndexPath(item: 0, section: 0), at: .middle, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launchesViewModel.showlaunches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchListTableViewCell.reuseIdentifier, for: indexPath) as? LaunchListTableViewCell,
              let launch = launchesViewModel.showlaunches?[indexPath.row] else {
            return UITableViewCell()
        }
        cell.config(launch: launch, imageDownloader: ImageDownloadService())
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let launch = launchesViewModel.showlaunches?[indexPath.row] else { return nil }
        var actions: [UIAction] = []
        if let articleLink = launch.articleLink {
            actions.append(UIAction(title: Translations.openArticleTitle) { [weak self] _ in
                self?.openLink(path: articleLink)
            })
        }
        if let videoLink = launch.webcastLink {
            actions.append(UIAction(title: Translations.openVideoTitle) { [weak self] _ in
                self?.openLink(path: videoLink)
            })
        }
        if let wikiLink = launch.wikipediaLink {
            actions.append(UIAction(title: Translations.openWikipediaTitle) { [weak self] _ in
                self?.openLink(path: wikiLink)
            })
        }
        if actions.isEmpty { return nil }
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil) { _ in
            UIMenu(title: Translations.contextMenuTitle, children: actions)
        }
    }
}
extension HomeViewController {
    // MARK: - Action Evensts
    
    @objc func showFilters() {
        let filtersCoordinator = FiltersCoordinator(rootViewController: self,
                                                                         launchesViewModel: launchesViewModel,
                                                                         onDismiss: { [weak self] selectedFilters, clearFilters in
            self?.updateList(filters: selectedFilters, clearFilters: clearFilters)
        })
        filtersCoordinator.start()
    }
    
    @objc func pullToRefresh() {
        fetchData()
        refreshControl.endRefreshing()
    }
    
    private func openLink(path: String) {
        if let url = URL(string: path), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
