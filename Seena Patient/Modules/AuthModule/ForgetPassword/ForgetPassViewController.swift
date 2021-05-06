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
    @IBOutlet weak var emailTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10
    }
    

    @IBAction func next(_ sender: Any) {

//        APIClient().forgetPassword(email: emailTF.text ?? "") { (res) in
//            print(res)
//        } onError: { (error) in
//            print(error)
//        }


        let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPForgetPasswordViewController") as? OTPForgetPasswordViewController
        newViewController!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newViewController!, animated: true)
//        self.present(newViewController!, animated: true, completion: nil)
    }


}
