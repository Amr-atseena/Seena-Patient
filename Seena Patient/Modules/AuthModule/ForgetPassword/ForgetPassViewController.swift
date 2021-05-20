//
//  ForgetPassViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/25/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class ForgetPassViewController: UIViewController {
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phoneNumTF: UITextField!
    
    let progressHUD = ProgressHUD(text: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10
    }
    

    @IBAction func next(_ sender: Any) {

        self.view.addSubview(progressHUD)


        APIClient().forgetPassword(phone: phoneNumTF.text ?? "") { (res) in
            print(res)
//            self.view.willRemoveSubview(progressHUD)

            self.progressHUD.removeFromSuperview()

            if res.error.validation == "User Not Found" {

                let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
                self.showAlertController(title: "Not found!".toLocalize, message: "User Not Found, enter your phone number again".toLocalize, actions: [okAction])
            }else{
                let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPForgetPasswordViewController") as? OTPForgetPasswordViewController
                newViewController!.modalPresentationStyle = .fullScreen
                newViewController?.userPhoneNum = self.phoneNumTF.text
                UserDefaults.standard.set(self.phoneNumTF.text, forKey: "num")
                self.navigationController?.pushViewController(newViewController!, animated: true)
            }
        } onError: { (error) in

            self.progressHUD.removeFromSuperview()
            let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

            self.showAlertController(title: "Error!".toLocalize, message: error, actions: [okAction])
        }



//        self.present(newViewController!, animated: true, completion: nil)
    }


}
