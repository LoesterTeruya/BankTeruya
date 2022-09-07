//
//  AccountController.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import UIKit


class AccountController: UIViewController, UITableViewDataSource, UITableViewDelegate, AccountDelegate, PayDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contaLabel: UILabel!
    
    @IBOutlet weak var saldoLabel: UILabel!
    
    @IBOutlet weak var tablepay: UITableView!
    
    var accountService = AccountService()
    var payService = PayService()
    
    var arrPay = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountService.delegate = self
        payService.delegate = self
        tablepay.dataSource = self
        tablepay.delegate = self
        tablepay.register(UINib(nibName: "TableController", bundle: nil), forCellReuseIdentifier: "TableController")
        
        accountService.fetchAccount()
        payService.fetchPay()
        tablepay.reloadData()
    }

    func didUpdateAccount(_ accountManager: AccountService, account: AccountModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = account.customerName
            self.contaLabel.text = account.accountNumber
            self.saldoLabel.text = String(account.checkingAccountBalance)
        }
    }
    
    func didUpdatePay(_ payManager: PayService, pay: [Any]) {
        //print(pay)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payService.getQnt()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "TableController") as? TableController)!
        
//        cell.contaLabel.text = "TESTE"
        return cell
        
    }
}

