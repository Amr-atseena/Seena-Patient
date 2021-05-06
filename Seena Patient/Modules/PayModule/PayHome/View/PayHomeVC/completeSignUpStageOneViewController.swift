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

//        APIClient().signUpsecond(birthdate: <#T##String#>, id: <#T##Int#>, financialProof: <#T##Int#>, ResidenceProof: <#T##Int#>) { (res) in
//            print(res)
//        } onError: { (error) in
//            print(error)
//        }


        let status = Status(profilePicture: false, idType: false, financialProof: false, residenceProof: false)
        let router = UploadDocumentsRouter()
        let interactor = UploadDocumentsInteractor()
        let vc = UploadDocumentsVC()
        let presenter = UploadDocumentsPresenter(view: vc, interactor: interactor, router: router, status: status)

        router.viewController = vc
        interactor.presenter = presenter
        vc.presenter = presenter
        self.navigationController?.pushViewController(vc, animated: true)


    }



}
