//
//  LoginViewModel.swift
//  TideGuard
//
//  Created by Faki Doosuur Doris on 31.03.2025.
//

import Foundation
import Combine

protocol LoginMainViewModelProtocol: UIKitViewModel where State == LoginViewState, Intent == LoginViewIntent {
    
}

final class LoginScreenViewModel: LoginMainViewModelProtocol {

    @Published private(set) var state: LoginViewState {
        didSet {
            stateDidChangeForLog.send()
        }
    }

    private(set) var stateDidChangeForLog = ObservableObjectPublisher()

    init () {
        self.state = .loading
    }

    func resetState() {
        self.state = .loading
    }

    func trigger(_ intent: LoginViewIntent, email: String, password: String) {
        
    }


}
