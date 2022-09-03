//
//  Coordinator.swift
//  BankTeruya
//
//  Created by Loester on 03/09/22.
//

import UIKit

protocol Coordinator {
    var currentViewController: UIViewController? { get set }
    func start()
}
