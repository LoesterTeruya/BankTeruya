//
//  AppCoordinator.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow?
    var currentViewController: UIViewController?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let service = LoginService()
        let loginPresenter = LoginPresenter(coordinator: self, service: service)
        let loginViewController = ViewController(presenter: loginPresenter)
        loginPresenter.viewController = loginViewController
        
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = loginViewController
        window?.makeKeyAndVisible()
        
        currentViewController = loginViewController
    }
}

extension AppCoordinator: LoginCoordinatorProtocol {
    func navigateToHome(loginModel: LoginModel) {
        let homeViewController = UIViewController()
        homeViewController.view.backgroundColor = .blue
        currentViewController?.present(homeViewController, animated: true, completion: { [weak self] in
            self?.currentViewController = homeViewController
        })
    }
    
    func navigateToAccount(loginModel: LoginModel) {
        let accountViewController = AccountController()
        currentViewController?.present(accountViewController, animated: true, completion: { [weak self] in
            self?.currentViewController = accountViewController
        })
    }
}
