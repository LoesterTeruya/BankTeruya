//
//  AccountController.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import UIKit


class AccountController: UIViewController, AccountDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contaLabel: UILabel!
    
    @IBOutlet weak var saldoLabel: UILabel!
    
    
    var accountService = AccountService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountService.delegate = self
        
        accountService.fetchAccount()
    }

    func didUpdateAccount(_ accountManager: AccountService, account: AccountModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = account.customerName
            self.contaLabel.text = account.accountNumber
            self.saldoLabel.text = String(account.checkingAccountBalance)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

