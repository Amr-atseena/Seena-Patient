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

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10
    }
    

    @IBAction func next(_ sender: Any) {

        APIClient().forgetPassword(phone: phoneNumTF.text ?? "") { (res) in
            print(res)
            if res.error.validation == "User Not Found" {
                self.showAlertController(title: "Not found!", message: "User Not Found, enter your phone number again", actions: [])
            }else{
                let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPForgetPasswordViewController") as? OTPForgetPasswordViewController
                newViewController!.modalPresentationStyle = .fullScreen
                newViewController?.userPhoneNum = self.phoneNumTF.text
                UserDefaults.standard.set(self.phoneNumTF.text, forKey: "num")
                self.navigationController?.pushViewController(newViewController!, animated: true)
            }
        } onError: { (error) in
            self.showAlertController(title: "Error!", message: error, actions: [])
        }



//        self.present(newViewController!, animated: true, completion: nil)
    }


}
