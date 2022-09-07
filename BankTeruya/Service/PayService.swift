//
//  PayService.swift
//  BankTeruya
//
//  Created by Loester on 07/09/22.
//

import Foundation

protocol PayDelegate {
    func didUpdatePay(_ payManager: PayService, pay: [Any])
    func didFailWithError(error: Error)
}


class PayService {
    let accountURL = "https://60bd336db8ab3700175a03b3.mockapi.io/treinamento/payments"
    
    var delegate: PayDelegate?
    
    func fetchPay(){
        performRequest(with: accountURL)
    }
    
    func getQnt() -> Int{
        return performRequest2(with: accountURL)
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
                    if let pay = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePay(self, pay: pay)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ payData: Data) -> [Any]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([PayData].self, from: payData)
            var payData = [Any]()
            for paydecoded in decodedData {
                payData.append(paydecoded)
            }
            
            return payData
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    func performRequest2(with urlString: String) -> Int {
        var pay: [Any]?
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    pay = self.parseJSON(safeData)
                }
            }
            task.resume()
        }
        return pay?.count ?? 0
    }
    
}
