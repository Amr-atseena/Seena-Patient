//
//  ProfileVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import MOLH

class ProfileVC: UIViewController, ProfileViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var holderView: UIView!
    @IBOutlet private var tagView: UIView!
    @IBOutlet private var statusLabel: UILabel!
    @IBOutlet private var userImage: UIImageView!
    @IBOutlet private var profileKeywordLabel: UILabel!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var transactionsKeywordLabel: UILabel!
    @IBOutlet private var settingsKeywordLabel: UILabel!
    @IBOutlet private var sendToFriendKeywordLabel: UILabel!
    @IBOutlet private var logOutKeywordLabel: UILabel!
    @IBOutlet weak var applicationStatusLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var tutorialKeywordLabel: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var termsAndLbl: UILabel!

    
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear()
    }
    // MARK: - Methods
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        // profileKeyword Label
//        profileKeywordLabel.text = presenter.localization.profile
//        profileKeywordLabel.font = DesignSystem.Typography.heading.font
        // userName Label
//        userNameLabel.font = DesignSystem.Typography.subHeading4.font
        //transactionsKeyword Label
        transactionsKeywordLabel.text = presenter.localization.transactions
        transactionsKeywordLabel.font = DesignSystem.Typography.subHeading4.font

        tutorialKeywordLabel.text = "Tutorials".toLocalize
        tutorialKeywordLabel.font = DesignSystem.Typography.subHeading4.font

        termsAndLbl.text = "Terms and conditions".toLocalize
        termsAndLbl.font = DesignSystem.Typography.subHeading4.font

        profileLbl.text = "Profile".toLocalize
        profileLbl.font = DesignSystem.Typography.subHeading4.font

        applicationStatusLbl.text = "Application status".toLocalize
        applicationStatusLbl.font = DesignSystem.Typography.subHeading4.font
        //settingsKeyword Label
        settingsKeywordLabel.text = presenter.localization.settings
        settingsKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //sendToFriendKeyword Label
        sendToFriendKeywordLabel.text = presenter.localization.sendToAFried
        sendToFriendKeywordLabel.font = DesignSystem.Typography.subHeading4.font
        //logOutKeyword Label
        logOutKeywordLabel.text = presenter.localization.logout
        logOutKeywordLabel.font = DesignSystem.Typography.subHeading4.font
    }
    func updateProfile(userName: String, image: String) {
//        userNameLabel.text = userName
//        userImage.kf.setImage(with: URL(string: image))
    }
    func setApplicationStatus(status: String, color: UIColor) {
//        statusLabel.text = status
//        holderView.isHidden = false
//        tagView.backgroundColor = color
//        UIView.animate(withDuration: 0.3) {
//            self.tagView.layoutIfNeeded()
//        }
    }
    func hideApplicationStatus() {
        holderView.isHidden = true
    }
    // MARK: - Actions
    @IBAction private func didTapOptionButton(_ sender: UIButton) {
        presenter.optionButtonTapped(atIndex: sender.tag)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(ProfileVC.className + "Release from Momery")
    }
}
