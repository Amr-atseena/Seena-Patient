//
//  SignUpVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 14/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, SignUpViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: SignUpPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SignUpVC.className, bundle: nil)
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
         debugPrint(SignUpVC.className + "Release from Momery")
    }
}
