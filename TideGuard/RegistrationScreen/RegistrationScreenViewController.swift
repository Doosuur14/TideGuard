//
//  RegistrationScreenViewController.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 07.04.2025.
//

import UIKit

class RegistrationScreenViewController: UIViewController, RegistrationDelegate {


    var registrationView: RegistrationScreenView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

    }

    private func setUpView() {
        registrationView = RegistrationScreenView(frame: view.bounds)
        view = registrationView
        registrationView?.delegate = self
        view.backgroundColor = .systemBackground
    }

    func didPressRegButton() {
        
    }



    
}
