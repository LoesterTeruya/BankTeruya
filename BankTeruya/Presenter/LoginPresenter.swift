//
//  LoginPresenter.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import Foundation
import UIKit

protocol LoginCoordinatorProtocol {
    func navigateToHome(loginModel: LoginModel)
    func navigateToAccount(loginModel: LoginModel)
}

protocol LoginPresenterProtocol {
    func login(username: String, password: String)
    func isValidForm(username: String, password: String) -> Bool
    func presentAlert()
}

final class LoginPresenter: LoginPresenterProtocol {
    
    private let service: LoginServiceProtocol
    var viewController: LoginViewControllerProtocol?
    var coordinator: LoginCoordinatorProtocol
    
    init(coordinator: LoginCoordinatorProtocol, service: LoginServiceProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func login(username: String, password: String) {
        self.service.login(endpoint: "Login", username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let loginModel):
                self.coordinator.navigateToAccount(loginModel: loginModel)
            case .failure(let error):
                self.viewController?.presentAlert(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func isValidForm(username: String, password: String) -> Bool {
        //return isValid(username: username) && password.isValidPassword()
        return true
    }
    
    private func isValid(username: String) -> Bool {
        //return username.isValidEmail() || username.isValidCpf()
        return true
    }
    
    func presentAlert() {
        viewController?.presentAlert(errorMessage: "Usuário ou senha incorreta")
    }
    
}
