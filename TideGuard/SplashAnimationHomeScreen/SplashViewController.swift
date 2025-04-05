//
//  SplashViewController.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 05.04.2025.
//

import UIKit

class SplashViewController: UIViewController {

    var splashView: SplashView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        splashView = SplashView(frame: view.bounds)
        view = splashView
//        splashView?.backgroundColor = UIColor(named: "MainColor")
        splashView?.backgroundColor = UIColor(red: 230/255, green: 240/255, blue: 250/255, alpha: 1)
    }

}
