//
//  SplashViewController.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 05.04.2025.
//

import UIKit

class SplashViewController: UIViewController {

    var splashView: SplashView?
    let animationDuration: TimeInterval = 5.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        splashView?.onAnimationComplete = { [weak self] in
            self?.transitionToLogin()
        }
    }

    private func setupView() {
        splashView = SplashView(frame: view.bounds)
        view = splashView
       // splashView?.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha: 1)
    }

    func transitionToLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }
    }

}
