//
//  Coordinator.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
}

