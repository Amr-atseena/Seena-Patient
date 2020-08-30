//
//  NotificationsHomeVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class NotificationsHomeVC: UIViewController, NotificationsHomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var notificationsKeywordLabel: UILabel!
    @IBOutlet private var notificationTableView: UITableView!
    // MARK: - Attributes
    var presenter: NotificationsHomePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: NotificationsHomeVC.className, bundle: nil)
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
    func setupNavBar(withTitle title: String) {
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // notifications Keyword Label
        notificationsKeywordLabel.text = presenter.localization.notifications
        notificationsKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        notificationsKeywordLabel.font = DesignSystem.Typography.heading.font
    }
    func setupNotificationsTableView() {
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.register(cellWithClass: NotificationCell.self)
    }
    func reloadNotificationsTableView() {
        notificationTableView.reloadData()
    }
    // MARK: - Actions
    // MARK: - DeInit
    deinit {
         debugPrint(NotificationsHomeVC.className + " Release from Momery")
    }
}
// MARK: - Notifications DataSource Implementation
extension NotificationsHomeVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: NotificationCell.self, for: indexPath)
        return cell
    }
}
// MARK: - NotficationsTableView Delegate Implementation
extension NotificationsHomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
