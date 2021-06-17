//
//  ClinicsSearchVC.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 21/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll
import SkeletonView
import MOLH
class ClinicsSearchVC: UIViewController, ClinicsSearchViewProtocol {
    // MARK: - Outlets
    @IBOutlet private var resultsKeyordLabel: UILabel!
    @IBOutlet private var spicialityLabel: UILabel!
    @IBOutlet private var searchTextFiled: UITextField!
    @IBOutlet private var noResultsView: UIView!
    @IBOutlet private var clinicsResultsTableView: UITableView!
    @IBOutlet weak var triedAr: UIImageView!
    @IBOutlet private var citiesCollectionView: UICollectionView!
    // MARK: - Attributes
    var presenter: ClinicsSearchPresenterProtocol!
    // MARK: - Init
    init() {
        super.init(nibName: ClinicsSearchVC.className, bundle: nil)
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
    // MARK: - Methods
    func setupUI() {
        // spiciality Label
        spicialityLabel.textColor = DesignSystem.Colors.secondaryText.color
        spicialityLabel.font = DesignSystem.Typography.title3.font
        // results keyword Label
        resultsKeyordLabel.text = presenter.localization.results
        resultsKeyordLabel.textColor = DesignSystem.Colors.secondaryText.color
        resultsKeyordLabel.font = DesignSystem.Typography.title1.font
        // search textFiled
        searchTextFiled.placeholder = presenter.localization.searchPlaceholder
        searchTextFiled.textColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.tintColor = DesignSystem.Colors.primaryText.color
        searchTextFiled.font = DesignSystem.Typography.title2.font
    }
    func setupInfintyScrolling() {
        self.clinicsResultsTableView.addInfiniteScroll { [weak self] (tableview) in
            guard let self = self else {return}
            self.presenter.retriveClinicsList()
            tableview.finishInfiniteScroll()
        }
    }
    func setSpeciality(name: String) {
        self.spicialityLabel.text = name
    }
    func setupClinicsTableView() {
        clinicsResultsTableView.delegate = self
        clinicsResultsTableView.dataSource = self
        clinicsResultsTableView.register(cellWithClass: ClinicCell.self)
        clinicsResultsTableView.register(cellWithClass: ClinicSkeletonCell.self)
    }
    func setupOptionsCollectionView(withOptionsAdapter optionsAdapter: OptionsAdapter) {
        citiesCollectionView.dataSource = optionsAdapter
        citiesCollectionView.delegate = optionsAdapter
        citiesCollectionView.register(cellWithClass: OptionCell.self)
    }
    func reloadClinicsTableView() {
        clinicsResultsTableView.reloadData()
    }
    func reloadOptions() {
        citiesCollectionView.reloadData()
    }
    func showSkelton() {
        clinicsResultsTableView.showAnimatedGradientSkeleton()
    }
    func hideSkelton() {
        clinicsResultsTableView.hideSkeleton()
    }
    func showNoDataView() {
        if MOLHLanguage.isArabic(){
            triedAr.isHidden = false
            self.noResultsView.isHidden = true
        }else{
            triedAr.isHidden = true
            self.noResultsView.isHidden = false

        }
    }
    func hideNoDataView() {
        self.noResultsView.isHidden = true
        triedAr.isHidden = true
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
         debugPrint(ClinicsSearchVC.className + " Release from Momery")
    }
}

// MARK: - ClinicsSearch TableView DataSource
extension ClinicsSearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfClinics
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ClinicCell.self, for: indexPath)
        presenter.config(ClinicCell: cell, atIndex: indexPath.row)
        cell.callButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.presenter.callButtonTapped(atIndex: indexPath.row)
        }
        return cell
    }
}
// MARK: - ClinicsSearch TableView Delegate
extension ClinicsSearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.clinicsResultsTableView(selectedAtIndex: indexPath.row)
    }
}
// MARK: - ClinicsSearch Skeleton DataSource Implementation
extension ClinicsSearchVC: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ClinicSkeletonCell.className
    }
}
