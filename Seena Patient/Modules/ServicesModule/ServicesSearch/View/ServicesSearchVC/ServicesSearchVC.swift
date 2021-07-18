//
//  ServicesSearchVC.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/17/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import SkeletonView
import UIScrollView_InfiniteScroll
class ServicesSearchVC: UIViewController, ServicesSearchViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var resultsKeyordLabel: UILabel!
    @IBOutlet private var searchTextFiled: UITextField!
    @IBOutlet private var noResultsView: EmptyStateView!
    @IBOutlet private var servicesResultsCollectionView: UICollectionView!
    // MARK: - Attributes
    var presenter: ServicesSearchPresenterProtocol!
    var type: Int?
    // MARK: - Init
    init() {
        super.init(nibName: ServicesSearchVC.className, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad(speci: type == -1 ? nil : type )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    // MARK: - Methods
    func setupUI() {
        // results keyword Label
        resultsKeyordLabel.text = presenter.localization.results
        resultsKeyordLabel.textColor = DesignSystem.Colors.secondaryText.color
        resultsKeyordLabel.font = DesignSystem.Typography.title1.font
        // search textFiled
        searchTextFiled.placeholder = presenter.localization.searchPlaceholder
        searchTextFiled.textColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.tintColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.font = DesignSystem.Typography.title2.font
        searchTextFiled.becomeFirstResponder()
    }
    func setupServicesTableView() {
        servicesResultsCollectionView.delegate = self
        servicesResultsCollectionView.dataSource = self
        servicesResultsCollectionView.register(cellWithClass: ServiceResultCell.self)
        servicesResultsCollectionView.register(cellWithClass: ServiceResultSkeltonCell.self)
    }
    func setupInifityScrolling() {
        servicesResultsCollectionView.addInfiniteScroll { [weak self] (collectionView) in
            guard let self = self else { return }
            collectionView.performBatchUpdates({ () -> Void in
               // update collection view
                self.presenter.fetchServicesList(forKeyword: self.searchTextFiled.text ?? "")
           }, completion: { (_) in
               // finish infinite scroll animations
               collectionView.finishInfiniteScroll()
           })
        }
    }
    func reloadServicesTableView() {
        servicesResultsCollectionView.reloadData()
    }
    func showSkelton() {
        servicesResultsCollectionView.showAnimatedGradientSkeleton()
    }
    func showNoDataView() {
        noResultsView.isHidden = false
    }
    func hideNoDataView() {
        noResultsView.isHidden = true
    }
    func hideSkelton() {
        servicesResultsCollectionView.hideSkeleton()
    }
    // MARK: - Actions
    @IBAction private func didTapBackButton(_ sender: UIButton) {
        presenter.backButtonTapped()
    }
    @IBAction private func didTapSerachButton(_ sender: UIButton) {
        presenter.searchButtonTapped(withKeyword: searchTextFiled.text)
    }
    // MARK: - DeInit
    deinit {
         debugPrint(ServicesSearchVC.className + "Release from Momery")
    }
}
// MARK: - ServicesResults CollectionView DataSource
extension ServicesSearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfService
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ServiceResultCell.self, for: indexPath)
        presenter.config(servicesSearchCell: cell, atIndex: indexPath.item)
        return cell
    }
}
// MARK: - ServicesResults CollectionView Delegate
extension ServicesSearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.servicesCollectionView(selectedAtIndex: indexPath.item)
    }
}
// MARK: - ServicesResults CollectionView FlowLayout
extension ServicesSearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.size.width  - 45) / 2
            let height: CGFloat = 130
            return CGSize(width: width, height: height)
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
// MARK: - Selekton View Implementation
extension ServicesSearchVC: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ServiceResultSkeltonCell.className
    }
}
