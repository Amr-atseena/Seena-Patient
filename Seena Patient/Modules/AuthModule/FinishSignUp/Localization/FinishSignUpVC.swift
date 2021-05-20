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
// the old one
        //        navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)

        // the second one
        UserDefaults.standard.removeObject(forKey: "financialProof")
        UserDefaults.standard.removeObject(forKey: "idType")
        UserDefaults.standard.removeObject(forKey: "profilePicture")
        UserDefaults.standard.removeObject(forKey: "residenceProof")
        UserDefaults.standard.removeObject(forKey: "financialProofLogin")
        UserDefaults.standard.removeObject(forKey: "idTypeLogin")
        UserDefaults.standard.removeObject(forKey: "profilePictureLogin")
        UserDefaults.standard.removeObject(forKey: "residenceProofLogin")
        
        let tabBar = HomeTabBarVC()
        self.present(tabBar, animated: true, completion: nil)





        // final one
//        _ = self.navigationController?.popToRootViewController(animated: true)

    }
    // MARK: - Deinit
    deinit {
        print(FinishSignUpVC.className + " Releas From Memory")
    }
}
