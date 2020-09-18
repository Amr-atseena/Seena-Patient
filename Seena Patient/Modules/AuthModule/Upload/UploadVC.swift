//
//  UploadVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UploadViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: UploadPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: UploadVC.className, bundle: nil)
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
         debugPrint(UploadVC.className + "Release from Momery")
    }
}
