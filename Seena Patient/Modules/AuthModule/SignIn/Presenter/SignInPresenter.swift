//
//  SignInPresenter.swift
//  Seena Patient
//
//  Created by Ahmed Zaki on 12/09/2020.
//  Copyright © 2020 RKAnjel. All rights reserved.
//

import Foundation
import CommonCrypto

class SignInPresenter: SignInPresenterProtocol {
    // MARK: - Attributes
    weak var view: SignInViewProtocol?
    var interactor: SignInInputInteractorProtocol?
    var router: SignInRouterProtocol?
    let localization = SignInLocalization()
    // MARK: - Init
    init(view: SignInViewProtocol?, interactor: SignInInputInteractorProtocol, router: SignInRouterProtocol ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    // MARK: - Methods
    func viewDidLoad() {
        view?.setupUI()
    }


    func signInButtonTapped(withPhone phone: String?, andPassword password: String?) {
        view?.showLoadingIndictor()
        interactor?.login(withPhone: phone ?? "", andPassword: password ?? "")

        let md5String = "IOS123".md5()
        print(md5String)

    }
    func signUpButtonTapped() {
        router?.go(to: .signUp)
    }
    func forgotPasswordTapped() {
        router?.go(to: .forgotPassword)
    }
}
// MARK: - SignInOutputInteractorProtocol Implementation
extension SignInPresenter: SignInOutputInteractorProtocol {
    func onLoginSuccess(withStatus status: Status) {
//        view?.hideLoadingIndictor()
//        if status.financialProof && status.idType &&
//            status.profilePicture && status.residenceProof {
//               router?.go(to: .profile)
//        } else {
//            router?.go(to: .uploadDocuments(status))
////            router?.go(to: .profile)
//
//        }
                       router?.go(to: .profile)


        

    }
    func onLoginFail(withMessage message: String) {
        view?.hideLoadingIndictor()
        router?.go(to: .alert(AlertEntity(title: "Error", message: message)))
    }


    


}



extension String {

func md5() -> String {

    let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
    var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5_Init(context)
    CC_MD5_Update(context, self, CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8)))
    CC_MD5_Final(&digest, context)
    context.deallocate()
    var hexString = ""
    for byte in digest {
        hexString += String(format:"%02x", byte)
    }

    return hexString
}
}
