//
//  PayHomeVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 06/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class PayHomeVC: UIViewController, PayHomeViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: PayHomePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: PayHomeVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK: - Methods
    // MARK: - Actions
    // MARK: - DeInit
    deinit {
         debugPrint(PayHomeVC.className + " Release from Momery")
    }
}
