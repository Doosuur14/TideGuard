//
//  AuthFlowCoordinator.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 14.04.2025.
//

import Foundation
import UIKit

protocol AuthFlowCoordinatorOutput: AnyObject {
    func authFlowCoordinatorEnteredUser()
}


final class AuthFlowCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var authFlowCoordinatorOutput: AuthFlowCoordinatorOutput?

    init(navigationController: UINavigationController, authFlowCoordinatorOutput: AuthFlowCoordinatorOutput) {
        self.navigationController = navigationController
       self.authFlowCoordinatorOutput = authFlowCoordinatorOutput
    }

    func start() {
        let homeController = HomeModuleBuilder().buildHomepage(output: self)
        navigationController.setViewControllers([homeController], animated: true)
    }

}
