//
//  HomeView.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit

class HomeView: UIView {
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }
    
    
    private func createSubViews() {
        searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.appBg.cgColor
        searchBar.showsCancelButton = true
        addSubview(searchBar)
        
        
        tableView = UITableView()
        addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableViewBottomConstraint = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableViewBottomConstraint
        ])
    }
    
}

