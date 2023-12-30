//
//  MainCoordinator.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit


class MainCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        //TODO: here we can decide which to display Login or home screen
        let loginVC = LoginVC()
        loginVC.coordinator = self
        loginVC.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(loginVC, animated: false)
    }
    
    
    func loginSuccess() {
        let homeVC = HomeVC()
        homeVC.coordinator = self
        navigationController.setViewControllers([homeVC], animated: true)
        
    }
    
    
    func showDetailOf(product: Product) {
        let detailVC = DetailVC()
        detailVC.vm = DetailVM(product: product)
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}
