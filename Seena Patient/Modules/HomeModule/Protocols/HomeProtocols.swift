//
//  HomeProtocols.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/15/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Home Router
enum HomeRoute {
    case serviceDetails
    case serviceList
}
protocol HomeRouterProtocol: class {
    var viewController: UIViewController? { get set }
    func go(to router: HomeRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Home Interactor
protocol HomeInputInteractorProtocol: class {
    var presenter: HomeOutputInteractorProtocol? { get set }
    // Presenter -> Interactor
}
protocol HomeOutputInteractorProtocol: class {
    // Interactor -> Presenter
}
// MARK: - Home Presenter
protocol HomePresenterProtocol: class {
    var router: HomeRouterProtocol? { get set }
    var interactor: HomeInputInteractorProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    var localization: HomeLocalization { get set }
    // View -> Presenter
    func viewDidLoad()
    func configure(categoryCell cell: CategoryCellView, atIndex index: Int )
    func serviceSelected(atIndex index: Int, andSection section: Int)
    func numberOfServices(atRow row: Int) -> Int
    var numberOfCategories: Int { get }
    var numberOfServicesOfWeak: Int { get }
}
// MARK: - Home View
protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol! { get set }
    // Presenter -> View
    func setupNavBar(withTitle title: String)
    func setupUI()
    func setupTableView()
    func showSkeltonView()
    func hideSkeltonView()
}
// MARK: - Category Cell View
protocol CategoryCellView {
    func setCategoryName(_ categoryName: String)
}
