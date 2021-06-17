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
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var searchTextFiled: UITextField!
    @IBOutlet var specialitiesTableView: UITableView!
    // MARK: - Attributes
    
    private lazy var seeAllOffersBtn: UIButton = {
        let button = UIButton()
        //        button.frame = CGRect(x: self.view.frame.size.width - 120, y: 5, width: 80, height: 30)
        
        //        button.backgroundColor = UIColor.red
        button.setTitle("See all".toLocalize, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(#colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        //        self.view.addSubview(button)
        return button
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        presenter.serachButtonTapped()
        
    }
    
    
    private lazy var operationsLabel: UILabel = {
        let opertionsLabel = UILabel()
        //        opertionsLabel.text = self.presenter.localization.beautySubscription
        opertionsLabel.text = "Offers".toLocalize
        opertionsLabel.font = DesignSystem.Typography.subHeading2.font
        opertionsLabel.textColor = DesignSystem.Colors.secondaryText.color
        return opertionsLabel
    }()
    private lazy var headerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        let header = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        header.backgroundColor = .clear
        header.isSkeletonable = true
        header.showsHorizontalScrollIndicator = false
        return header
    }()
    private lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 290))
        headerView.addSubview(operationsLabel)
        headerView.addSubview(headerCollectionView)
        headerView.addSubview(seeAllOffersBtn)
        headerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        operationsLabel.translatesAutoresizingMaskIntoConstraints = false
        seeAllOffersBtn.translatesAutoresizingMaskIntoConstraints = false
        let constraint = [
            operationsLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            operationsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            operationsLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5),
            operationsLabel.bottomAnchor.constraint(equalTo: headerCollectionView.topAnchor, constant: -10),
            seeAllOffersBtn.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            //            seeAllOffersBtn.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 280),
            seeAllOffersBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            seeAllOffersBtn.bottomAnchor.constraint(equalTo: headerCollectionView.topAnchor, constant: -10),
            headerCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraint)
        return headerView
    }()
    
    var presenter: HomePresenterProtocol!
    //    var presenter2: ClinicsHomePresenterProtocol!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
        
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
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.register(cellWithClass: PackageSkeltonCell.self)
        headerCollectionView.register(cellWithClass: PackageCell.self)
        
        
        specialitiesTableView.tableHeaderView = headerView
        
    }
    func setUsername(_ username: String) {
        usernameLabel.text = username
    }
    func reloadCategoryTableView() {
        specialitiesTableView.reloadData()
    }
    func reloadPackageCollectionView() {
        headerCollectionView.reloadData()
    }
    func showSkeltonView() {
        headerCollectionView.showAnimatedGradientSkeleton()
        specialitiesTableView.showAnimatedGradientSkeleton()
    }
    func hideSkeltonView() {
        headerCollectionView.hideSkeleton()
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
    var router: ClinicsHomeRouterProtocol?
    var presenter2: ClinicsHomePresenterProtocol!
    weak var view2: ClinicsHomeViewProtocol?
    
    var specialities = [Speciality]() {
        didSet {
            view2?.reloadClinics()
        }
    }
    
}
// MARK: - CategoriesTableView DataSource Implementation
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCategories
        //        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: SpectialityCell.self, for: indexPath)
        presenter.configure(spectialityCell: cell, atIndex: indexPath.row)
        //        cell.spectialityNameLabel.text = "Clinics"
        cell.callBack = {
            
            if cell.spectialityNameLabel.text == "Clinics" || cell.spectialityNameLabel.text == "العيادات"{
                self.navigationController?.pushViewController(ClinicsHomeRouter.assembleModule(), animated: true)
            }else{
                self.presenter.serviceSelected(atIndex: indexPath.row, andSection: -2)
            }
            
            //            self.navigationController?.pushViewController(ClinicsHomeRouter.assembleModule(), animated: true)
            
            
            
            
        }
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
        if
            collectionView == headerCollectionView {
            return presenter.numberOfPackages
        }
        
        else {
            
            if collectionView.tag == 0 {
                return presenter.numberOfClincs
            }else{
                return presenter.numberOfServices(atRow: collectionView.tag)
            }
            //            return presenter.numberOfCategories
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            let cell = collectionView.dequeueReusableCell(withClass: PackageCell.self, for: indexPath)
            presenter.configure(packageCell: cell, atIndex: indexPath.item)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withClass: ServiceCell.self, for: indexPath)
            presenter.configure(serviceCell: cell, atIndex: indexPath.item, andSection: collectionView.tag)
            return cell
        }
    }
}
// MARK: - ServicesCollection Delegate Implementation
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if
            collectionView == headerCollectionView{
            presenter.serviceSelected(atIndex: indexPath.item, andSection: -1)
        } else {
            //            presenter.serviceSelected(atIndex: indexPath.item, andSection: -2)
            
            presenter.serviceSelected(atIndex: indexPath.item, andSection: collectionView.tag)
            
            
        }
    }
}

// MARK: - ServicesCollection FlowLayoutDelegate Implementation
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if
            collectionView == headerCollectionView {
            //            let width = (collectionView.frame.size.width - 30 ) / 1.05
            let width = (collectionView.frame.size.width ) / 1.05
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
        if
            collectionView != headerCollectionView {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        } else {
            return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
        }
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
