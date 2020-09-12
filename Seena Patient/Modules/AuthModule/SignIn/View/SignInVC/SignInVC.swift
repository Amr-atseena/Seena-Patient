//
//  SignInVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SignInVC: UIViewController, SignInViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: SignInPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SignInVC.className, bundle: nil)
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
         debugPrint(SignInVC.className + "Release from Momery")
    }
}
