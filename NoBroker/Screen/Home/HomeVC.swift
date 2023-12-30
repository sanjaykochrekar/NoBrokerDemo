//
//  HomeVC.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit


class HomeVC: UIViewController {
    weak var coordinator: MainCoordinator!
    var homeView: HomeView!
    lazy var vm = HomeVM()
    
    
    override func loadView() {
        super.loadView()
        
        homeView = HomeView()
        view.addSubview(homeView)
        view.backgroundColor = .appBg
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.searchBar.delegate = self
        homeView.tableView.register(ProductTVCell.self, forCellReuseIdentifier: "ProductTVCell")
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        vm.delegate = self
        vm.fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            homeView.tableViewBottomConstraint.constant = -keyboardSize.height
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        homeView.tableViewBottomConstraint.constant = 0
    }
    
}



//MARK: UISearchBarDelegate methods
extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.searchProduct(searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.searchTextField.text = ""
        vm.cancelSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}



//MARK: UITableViewDataSource methods
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.getRowCount(section: section)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = vm.getItemAtIndex(indexPath: indexPath) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! ListCell
        cell.populate(data: item)
        return cell as! UITableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && vm.continueLoading && !vm.isSearching {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            if vm.getRowCount(section: indexPath.section) < indexPath.row + 3 {
                vm.fetchData()
            }
            homeView.tableView.tableFooterView = spinner
            homeView.tableView.tableFooterView?.isHidden = false
        } else if !vm.continueLoading || vm.isSearching{
            homeView.tableView.tableFooterView?.isHidden = true
            homeView.tableView.tableFooterView = nil
        }
    }
    
}



//MARK: UITableViewDelegate methods
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let product = vm.getItemAtIndex(indexPath: indexPath) as? Product else { return }
        coordinator.showDetailOf(product: product)
    }
    
}



//MARK: HomeVMDelegate methods
extension HomeVC: HomeVMDelegate {
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.homeView.tableView.reloadData()
        }
    }
    
}
