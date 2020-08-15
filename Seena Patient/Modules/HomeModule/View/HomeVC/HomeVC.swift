//
//  HomeVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, HomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet var helloKeywordLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var searchTextFiled: UITextField!
    @IBOutlet var categoriesTableView: UITableView!
    // MARK: - Attributes
    private lazy var headerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let header = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200), collectionViewLayout: layout)
        header.backgroundColor = .clear
        header.showsHorizontalScrollIndicator = false
        return header
    }()
    var presenter: HomePresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: HomeVC.className, bundle: nil)
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
        self.configureNavigationBar(titleColor: DesignSystem.Colors.primaryNavBarText.color,
                                    backgoundColor: DesignSystem.Colors.primaryNavBarBackground.color,
                                    tintColor: DesignSystem.Colors.primaryNavBarBackground.color,
                                    title: title,
                                    preferredLargeTitle: false)
    }
    func setupUI() {
        helloKeywordLabel.text = presenter.localization.hello
        helloKeywordLabel.font = DesignSystem.Typography.title1.font
        helloKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        usernameLabel.text = presenter.localization.guest
        usernameLabel.textColor = DesignSystem.Colors.secondaryText.color
        usernameLabel.font = DesignSystem.Typography.largeTitle.font
        searchTextFiled.placeholder = presenter.localization.searchPlaceholder
        searchTextFiled.textColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.font = DesignSystem.Typography.title2.font
    }
    func setupTableView() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.register(cellWithClass: CategoryCell.self)
        headerView.delegate = self
        headerView.dataSource = self
        headerView.register(cellWithClass: ServiceOfTheWeakCell.self)
        categoriesTableView.tableHeaderView = headerView
    }
    func showSkeltonView() {
    }
    func hideSkeltonView() {
    }
    // MARK: - Actions
    @IBAction private func didTapSearchButton(_ sender: UIButton) {
    }
    // MARK: - DeInit
    deinit {
        print(HomeVC.className + "Release from Momery")
    }
}
// MARK: - CategoriesTableView DataSource Implementation
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CategoryCell.self, for: indexPath)
        presenter.configure(categoryCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - CategoriesTableView Delegate Implementation
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let categoryCell = cell as? CategoryCell else {
            return
        }
        categoryCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}
// MARK: - ServicesCollection DataSoucrce Implementation
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerView {
            return presenter.numberOfServicesOfWeak
        } else {
            return presenter.numberOfServices(atRow: collectionView.tag)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerView {
           let cell = collectionView.dequeueReusableCell(withClass: ServiceOfTheWeakCell.self, for: indexPath)
           return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: ServiceCell.self, for: indexPath)
            return cell
        }
    }
}
// MARK: - ServicesCollection Delegate Implementation
extension HomeVC: UICollectionViewDelegate {
}

// MARK: - ServicesCollection FlowLayoutDelegate Implementation
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerView {
            let width = (collectionView.frame.size.width  - 30) / 1.25
            let height = (collectionView.frame.size.height)
            return CGSize(width: width, height: height)
        } else {
            let width = (collectionView.frame.size.width  - 30) / 3.25
            let height = (collectionView.frame.size.height)
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
