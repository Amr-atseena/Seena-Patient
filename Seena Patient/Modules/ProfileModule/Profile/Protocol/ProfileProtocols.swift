//
//  ProfileProtocols.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 29/08/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Profile Router
enum ProfileRoute {
    case signIn
    case transactions
    case settings
    case share
    case alert(AlertEntity)
}
protocol ProfileRouterProtocol {
    // Presenter -> Router
    var viewController: UIViewController? { get set }
    func go(to router: ProfileRoute)
    static func assembleModule() -> UIViewController
}
// MARK: - Profile Interactor
protocol ProfileInputInteractorProtocol: class {
    var presenter: ProfileOutputInteractorProtocol? { get set }
    var localDataManager: ProfileLocalDataManagerProtocol { get set }
    // Presenter -> Interactor
    func retriveUser()
    func removeUser()
}
protocol ProfileOutputInteractorProtocol: class {
    // Interactor -> Presenter
    func onRetriveUser(_ user: User?)
}
// MARK: - Profile Preseneter
protocol ProfilePresenterProtocol: class {
    var view: ProfileViewProtocol? { get set}
    var interactor: ProfileInputInteractorProtocol? { get set}
    var router: ProfileRouterProtocol? { get set }
    var localization: ProfileLocalization { get }
    // view -> Presenter
    func viewDidLoad()
    func viewWillAppear()
    func optionButtonTapped(atIndex index: Int)
    func logOut()
}
// MARK: - Profile View
protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol! { get set }
    // Presenter -> View
    func setupUI()
    func updateProfile(userName: String, image: String)
}
