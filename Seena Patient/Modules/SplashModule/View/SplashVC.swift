//
//  SplashVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class SplashVC: UIViewController, SplashViewProtocol {
    // MARK: - Outlets
    @IBOutlet var loadingIndictor: UIActivityIndicatorView!
    // MARK: - Attributes
    var presenter: SplashPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: SplashVC.className, bundle: nil)
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
    func showLoadingIndictor() {
        loadingIndictor.startAnimating()
     }
     func hideLoadingIndictor() {
        loadingIndictor.stopAnimating()
     }
    // MARK: - DeInit
    deinit {
        print(SplashVC.className + "Release from Momery")
    }
}
