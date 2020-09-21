//
//  TransactionsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class TransactionsVC: UIViewController, TransactionsViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: TransactionsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: TransactionsVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    // MARK: - Methods
    // MARK: - Actions
    // MARK: - DeInit
    deinit {
         debugPrint(TransactionsVC.className + " Release from Momery")
    }
}
