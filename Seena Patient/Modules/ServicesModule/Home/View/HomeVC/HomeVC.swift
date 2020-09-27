//
//  HomeVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import SkeletonView
class HomeVC: UIViewController, HomeViewProtocol {
    // MARK: - Outlets
    @IBOutlet var helloKeywordLabel: UILabel!
    @IBOutlet var beautySubscriptionKeywordLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var searchTextFiled: UITextField!
    @IBOutlet var specialitiesTableView: UITableView!
    // MARK: - Attributes
    private lazy var headerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let header = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 250), collectionViewLayout: layout)
        header.backgroundColor = .clear
        header.isSkeletonable = true
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
        self.navigationController?.navigationBar.isHidden = true
    }
    func setupUI() {
        // hello keyword label
        helloKeywordLabel.text = presenter.localization.hello
        helloKeywordLabel.font = DesignSystem.Typography.title1.font
        helloKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        // beauty subscriptions keyword label
        beautySubscriptionKeywordLabel.text = presenter.localization.beautySubscription
        beautySubscriptionKeywordLabel.font = DesignSystem.Typography.subHeading2.font
        beautySubscriptionKeywordLabel.textColor = DesignSystem.Colors.secondaryText.color
        // username label
        usernameLabel.text = presenter.localization.guest
        usernameLabel.textColor = DesignSystem.Colors.secondaryText.color
        usernameLabel.font = DesignSystem.Typography.largeTitle.font
        // search textFiled
        searchTextFiled.placeholder = presenter.localization.searchPlaceholder
        searchTextFiled.textColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.font = DesignSystem.Typography.title2.font
    }
    func setupTableView() {
        specialitiesTableView.delegate = self
        specialitiesTableView.dataSource = self
        specialitiesTableView.register(cellWithClass: SpectialityCell.self)
        specialitiesTableView.register(cellWithClass: SpectialitySkeltonCell.self)
        headerView.delegate = self
        headerView.dataSource = self
        headerView.register(cellWithClass: PackageSkeltonCell.self)
        headerView.register(cellWithClass: PackageCell.self)
        specialitiesTableView.tableHeaderView = headerView
    }
    func reloadCategoryTableView() {
        specialitiesTableView.reloadData()
    }
    func reloadPackageCollectionView() {
        headerView.reloadData()
    }
    func showSkeltonView() {
        headerView.showAnimatedGradientSkeleton()
        specialitiesTableView.showAnimatedGradientSkeleton()
    }
    func hideSkeltonView() {
        headerView.hideSkeleton()
        specialitiesTableView.hideSkeleton()
    }
    // MARK: - Actions
    @IBAction private func didTapSearchButton(_ sender: UIButton) {
        presenter.serachButtonTapped()
    }
    // MARK: - DeInit
    deinit {
        debugPrint(HomeVC.className + " Release from Momery")
    }
}
// MARK: - CategoriesTableView DataSource Implementation
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SpectialityCell.self, for: indexPath)
        presenter.configure(spectialityCell: cell, atIndex: indexPath.row)
        return cell
    }
}
// MARK: - CategoriesTableView Delegate Implementation
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let specitalityCell = cell as? SpectialityCell else {
            return
        }
        specitalityCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
}
// MARK: - ServicesCollection DataSoucrce Implementation
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerView {
            return presenter.numberOfPackages
        } else {
            return presenter.numberOfServices(atRow: collectionView.tag)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerView {
            let cell = collectionView.dequeueReusableCell(withClass: PackageCell.self, for: indexPath)
            presenter.configure(packageCell: cell, atIndex: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withClass: ServiceCell.self, for: indexPath)
            presenter.configure(serviceCell: cell, atIndex: indexPath.item, andSection: collectionView.tag)
            return cell
        }
    }
}
// MARK: - ServicesCollection Delegate Implementation
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerView {
            presenter.serviceSelected(atIndex: indexPath.item, andSection: -1)
        } else {
            presenter.serviceSelected(atIndex: indexPath.item, andSection: collectionView.tag)
        }
    }
}

// MARK: - ServicesCollection FlowLayoutDelegate Implementation
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == headerView {
            let width = (collectionView.frame.size.width  - 30) / 1.05
            let height = (collectionView.frame.size.height)
            return CGSize(width: width, height: height)
        } else {
            let width = (collectionView.frame.size.width  - 30) / 2.1
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
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
// MARK: - Selekton View Implementation
extension HomeVC: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PackageSkeltonCell.className
    }
}
extension HomeVC: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return SpectialitySkeltonCell.className
    }
}
