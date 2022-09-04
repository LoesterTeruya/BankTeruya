//
//  AccountService.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import Foundation

protocol AccountDelegate {
    func didUpdateAccount(_ accountManager: AccountService, account: AccountModel)
    func didFailWithError(error: Error)
}


class AccountService {
    let accountURL = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/Login"
    
    var delegate: AccountDelegate?
    
    func fetchAccount(){
        performRequest(with: accountURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let account = self.parseJSON(safeData) {
                        self.delegate?.didUpdateAccount(self, account: account)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ accountData: Data) -> AccountModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([AccountData].self, from: accountData)
            let conta = decodedData[0]
            
            let id = conta.id
            let customerName = conta.customerName
            let accountNumber = conta.accountNumber
            let branchNumber = conta.branchNumber
             let checkingAccountBalance = conta.checkingAccountBalance
            
            let account = AccountModel(id: id!, customerName: customerName!, accountNumber: accountNumber!, branchNumber: branchNumber!, checkingAccountBalance: checkingAccountBalance!)
            return account
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
