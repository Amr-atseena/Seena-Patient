//
//  PaymentChannelVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 07/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PaymentChannelVC: UIViewController, PaymentChannelViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: PaymentChannelPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PaymentChannelVC.className, bundle: nil)
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
         debugPrint(PaymentChannelVC.className + "Release from Momery")
    }
}
