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
    @IBOutlet private var userImage: UIImageView!
    @IBOutlet private var profileKeywordLabel: UILabel!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var transactionsKeywordLabel: UILabel!
    @IBOutlet private var settingsKeywordLabel: UILabel!
    @IBOutlet private var sendToFriendKeywordLabel: UILabel!
    @IBOutlet private var logOutKeywordLabel: UILabel!
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
        presenter.viewWillAppear()
    }
    // MARK: - Methods
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        // profileKeyword Label
        profileKeywordLabel.text = presenter.localization.profile
        profileKeywordLabel.font = DesignSystem.Typography.heading.font
        // userName Label
        userNameLabel.font = DesignSystem.Typography.subHeading4.font
        //transactionsKeyword Label
        transactionsKeywordLabel.text = presenter.localization.transactions
        transactionsKeywordLabel.font = DesignSystem.Typography.subHeading4.font
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
        userNameLabel.text = userName
        userImage.kf.setImage(with: URL(string: image))
    }
    // MARK: - Actions
    // MARK: - DeInit
    deinit {
         debugPrint(ProfileVC.className + "Release from Momery")
    }
}
