//
//  FinishSignUpVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 20/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class FinishSignUpVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var finishButton: UIButton!
    @IBOutlet private var thxMessageLabel: UILabel!
    // MARK: - Attributes
    let localization = FinishSignUpLocalization()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    // MARK: - Methods
    func setupUI() {
        //thxMessage Label
        thxMessageLabel.text = localization.thxMessage
        thxMessageLabel.font = DesignSystem.Typography.subHeading4.font
        //finish Button
        finishButton.setTitle(localization.finish, for: .normal)
        finishButton.titleLabel?.font = DesignSystem.Typography.subHeading3.font
    }
    // MARK: - Actions
    @IBAction private func didTapFinishButton(_ sender: UIButton) {
//        navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)
        let tabBar = HomeTabBarVC()
//        viewController?.present(tabBar, animated: true)
        self.present(tabBar, animated: true, completion: nil)
    }
    // MARK: - Deinit
    deinit {
        print(FinishSignUpVC.className + " Releas From Memory")
    }
}
