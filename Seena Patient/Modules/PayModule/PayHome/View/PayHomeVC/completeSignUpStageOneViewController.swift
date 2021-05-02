//
//  completeSignUpStageOneViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/29/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class CompleteSignStageOneViewController: UIViewController {

    var presenter: SignUpPresenterProtocol!
    var router: SignUpRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()


}
    
    @IBAction func finish(_ sender: Any) {
//        presenter.finishButtonTapped()

//        router?.go(to: .uploadDocuments(status))


//        navigationController?.pushViewController(uploadDocuments, animated: true)

    }


    @IBAction func button(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "UploadDocumentsVC", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "UploadDocumentsVC") as? UploadDocumentsVC
//        newViewController!.modalPresentationStyle = .fullScreen
//        self.present(newViewController!, animated: true, completion: nil)

//                presenter.finishButtonTapped()
//
//        router?.go(to: .uploadDocuments(status))
//        self.navigationController?.pushViewController(UploadDocumentsRouter.assembleModule(), animated: true)

//        let uploadDocuments = UploadDocumentsRouter.assembleModule(withStatus: status)
//        uploadDocuments.modalPresentationStyle = .fullScreen
        let status = Status(profilePicture: false, idType: false, financialProof: false, residenceProof: false)
        let router = UploadDocumentsRouter()
        let interactor = UploadDocumentsInteractor()
        let vc = UploadDocumentsVC()
        let presenter = UploadDocumentsPresenter(view: vc, interactor: interactor, router: router, status: status)

        router.viewController = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        self.navigationController?.pushViewController(vc, animated: true)

//        self.pres?.pushViewController(UploadDocumentsVC(), animated: true)

//        router?.go(to: .uploadDocuments(status))
    }

    private func navigateToUploadDocumets(withStatus status: Status) {
        let uploadDocuments = UploadDocumentsRouter.assembleModule(withStatus: status)
//        viewController?.hidesBottomBarWhenPushed = true
//        self.navigateToUploadDocumets(withStatus: Status)
        self.navigationController?.pushViewController(uploadDocuments, animated: true)
//        viewController?.hidesBottomBarWhenPushed = false
    }


}
