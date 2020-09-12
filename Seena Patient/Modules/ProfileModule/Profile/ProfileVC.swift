//
//  ProfileVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, ProfileViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: ProfilePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ProfileVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setViewControllers ([SignInRouter.assembleModule()], animated: false)
    }
    // MARK: - Methods
    // MARK: - Actions
    // MARK: - DeInit
    deinit {
         debugPrint(ProfileVC.className + "Release from Momery")
    }
}
