//
//  LoginViewController.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 31.03.2025.
//

import UIKit

class LoginViewController: UIViewController, LoginViewDelegate {

    var loginView: LoginScreenView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView() {
        loginView = LoginScreenView(frame: view.bounds)
        view = loginView
        loginView?.delegate = self
        view.backgroundColor = .systemBackground
    }


    func didPressLoginButton() {

    }




}
