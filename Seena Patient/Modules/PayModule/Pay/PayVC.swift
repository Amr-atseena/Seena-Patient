//
//  PayVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 08/10/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayVC: UIViewController, PayViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: PayPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PayVC.className, bundle: nil)
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
         debugPrint(PayVC.className + "Release from Momery")
    }
}
