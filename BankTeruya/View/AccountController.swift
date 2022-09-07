//
//  AccountController.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import UIKit


class AccountController: UIViewController, AccountDelegate, PayDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contaLabel: UILabel!
    
    @IBOutlet weak var saldoLabel: UILabel!
    
    
    var accountService = AccountService()
    var payService = PayService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountService.delegate = self
        payService.delegate = self
        
        accountService.fetchAccount()
        payService.fetchPay()
    }

    func didUpdateAccount(_ accountManager: AccountService, account: AccountModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = account.customerName
            self.contaLabel.text = account.accountNumber
            self.saldoLabel.text = String(account.checkingAccountBalance)
        }
    }
    
    func didUpdatePay(_ payManager: PayService, pay: [Any]) {
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

