//
//  AccountData.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import Foundation

struct AccountData: Codable {
    let id: String?
    let customerName: String?
    let accountNumber: String?
    let branchNumber: String?
    let checkingAccountBalance: Double?
}
