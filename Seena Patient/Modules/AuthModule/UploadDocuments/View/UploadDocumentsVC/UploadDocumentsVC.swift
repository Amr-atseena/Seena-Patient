//
//  UploadDocumentsVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 18/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class UploadDocumentsVC: UIViewController, UploadDocumentsViewProtocol {
    // MARK: - Outlets
    // MARK: - Attributes
    var presenter: UploadDocumentsPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: UploadDocumentsVC.className, bundle: nil)
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
         debugPrint(UploadDocumentsVC.className + "Release from Momery")
    }
}
