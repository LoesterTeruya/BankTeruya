//
//  PayModel.swift
//  BankTeruya
//
//  Created by Loester on 07/09/22.
//

import Foundation

struct PayModel: Decodable {
    let paymentDate: String?
    let electricityBill: String?
    let id: String?
}
