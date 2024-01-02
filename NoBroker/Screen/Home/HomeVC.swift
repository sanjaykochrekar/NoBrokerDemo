//
//  HomeVC.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit



class HomeVC: UITableViewController {
    weak var coordinator: MainCoordinator!
    lazy var vm = HomeVM()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    
    override func loadView() {
        super.loadView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .appBg
        tableView.register(ProductTVCell.self, forCellReuseIdentifier: "ProductTVCell")
        
        vm.delegate = self
        vm.fetchData()

        navigationAndSearchSetup()
    }
    
    
    private func navigationAndSearchSetup() {
        title = "Products"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}


extension HomeVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        if searchText.isEmpty {
            vm.cancelSearch()
        } else {
            vm.searchProduct(searchText)
        }
    }
    
}



//MARK: UITableView dataSource methods
extension HomeVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getRowCount(section: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = vm.getItemAtIndex(indexPath: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! ListCell
        cell.populate(data: item)
        return cell as! UITableViewCell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && vm.continueLoading && !vm.isSearching {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            if vm.getRowCount(section: indexPath.section) < indexPath.row + 3 {
                vm.fetchData()
            }
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        } else if !vm.continueLoading || vm.isSearching{
            tableView.tableFooterView?.isHidden = true
            tableView.tableFooterView = nil
        }
    }
    
}



//MARK: UITableView delegate methods
extension HomeVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = vm.getItemAtIndex(indexPath: indexPath) as? Product else { return }
        coordinator.showDetailOf(product: product)
    }
    
}



//MARK: HomeVMDelegate methods
extension HomeVC: HomeVMDelegate {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}
