//
//  MainFLowCoordinator.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 17.04.2025.
//

import Foundation
import UIKit


protocol MainFlowCoordinatorProtocol: AnyObject {
    func mainFlowSignOutUser()
}

class MainFlowCoordinator: Coordinator {

    var navigationController: UINavigationController
    private var mainFlowCoordinatorOutput: MainFlowCoordinatorProtocol?

    init(navigationController: UINavigationController, mainFlowCoordinatorOutput: MainFlowCoordinatorProtocol) {
        self.navigationController = navigationController
        self.mainFlowCoordinatorOutput = mainFlowCoordinatorOutput
    }

    func start() {
        let mainviewController = SafetyModuleBuilder().buildMain()
        mainviewController.tabBarItem = UITabBarItem(title: "Safety", image: UIImage(systemName: "exclamationmark.triangle.fill"), tag: 0)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainviewController]
        tabBarController.tabBar.tintColor = UIColor(named: "MainColor")
        tabBarController.tabBar.backgroundColor = .systemGray6
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
