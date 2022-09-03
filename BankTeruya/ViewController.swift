//
//  ViewController.swift
//  BankTeruya
//
//  Created by Loester on 02/09/22.
//

import UIKit

protocol LoginViewControllerProtocol {
    func presentAlert(errorMessage: String)
}

class ViewController: UIViewController, LoginViewControllerProtocol {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFied: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setup()
    }

    private var presenter: LoginPresenterProtocol
    
    // MARK: Lifecycle
    
    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//    private func setup() {
//        self.loginButton.setCorner(radius: 5)
//    }

    // MARK: Methods
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextFied.text ?? ""
        
        if self.presenter.isValidForm(username: username, password: password) {
            self.presenter.login(username: username, password: password)
        } else {
            self.presenter.presentAlert()
        }
    }
    
    
    func presentAlert(errorMessage: String) {
        self.presentAlert(errorMessage: errorMessage)
    }
}

