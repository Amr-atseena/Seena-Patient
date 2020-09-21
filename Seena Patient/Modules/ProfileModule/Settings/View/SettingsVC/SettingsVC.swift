//
//  SettingsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, SettingsViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: SettingsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SettingsVC.className, bundle: nil)
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
         debugPrint(SettingsVC.className + "Release from Momery")
    }
}
