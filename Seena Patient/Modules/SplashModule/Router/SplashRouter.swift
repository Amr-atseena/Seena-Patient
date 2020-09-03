//
//  SplashRouter.swift
//  Seena Patient
//
//  Created by RKAnjel on 8/14/20.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import UIKit

class SplashRouter: SplashRouterProtocol {
    // MARK: - Attributes
    weak var viewController: UIViewController?
    // MARK: - Assemble
    static func assembleModule() -> UIViewController {
        let view = SplashVC()
        let localDataManager = SplashLocalDataManager()
        let remoteDataManager = SplashRemoteDataManager()
        let interactor = SplashInteractor(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: router)
        interactor.presenter = presenter
        view.presenter = presenter
        router.viewController = view
       return view
    }
    // MARK: - Routing
    func go(to router: SplashRoute) {
        switch router {
        case .tabBar:
            let tabBar = HomeTabBarVC()
            viewController?.present(tabBar, animated: true)
        }
    }

}
