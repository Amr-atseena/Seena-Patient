//
//  NewPasswordViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/4/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class NewPasswordViewController: UIViewController {
    weak var viewController: UIViewController?
    @IBOutlet weak var password: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var newPass: SkyFloatingLabelTextFieldWithIcon!

    let progressHUD = ProgressHUD(text: "")


    override func viewDidLoad() {
        super.viewDidLoad()

        newPass.layer.cornerRadius = 10


        newPass.addTarget(self, action: #selector(textDidBeginEditing), for: .editingDidEnd)
        tabBarController?.tabBar.isHidden = true

    }

    @objc func textDidBeginEditing(sender:UITextField) -> Void
    {
        textFieldsSetup()
    }

    func textFieldsSetup(){
        if password.text?.isEmpty == true && newPass.text?.isEmpty == true{
            print("Write your passwords")
        }
        else{
            if password.text == newPass.text {
                print("Matching")
                texfieldImage(textField: password, imageName: "right")
                texfieldImage(textField: newPass, imageName: "right")
            }else{
                print("Not matching")
                texfieldImage(textField: password, imageName: "right")
                texfieldImage(textField: newPass, imageName: "wrong")
            }
        }
    }

    func texfieldImage(textField: SkyFloatingLabelTextField, imageName : String){
        textField.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: imageName)
        imageView.image = image
        textField.rightView = imageView

        //        if in arabic
        //        textField.leftView = imageView

    }


    let phoneee = UserDefaults.standard.string(forKey: "num")
    

    @IBAction func done(_ sender: Any) {

        self.view.addSubview(progressHUD)

        let password = validpassword(mypassword: self.newPass.text!)
        if(password == true){
            print("Valid Password")

            APIClient().resetPass(phone: phoneee!, newPassword: newPass.text!) { (res) in
                print(res)
                self.progressHUD.removeFromSuperview()

                if res.error.status == false{
                    let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

                    self.showAlertController(title: "Error!".toLocalize, message: res.error.validation, actions: [okAction])
                }else{
                _ = self.navigationController?.popToRootViewController(animated: true)
                }
            } onError: { (error) in
                self.progressHUD.removeFromSuperview()
                print(error)
            }


        }else
        {
            let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)
            showAlertController(title: "Password validation!".toLocalize, message: "Password should be more than 8 characters, including numbers, uppercase letter, and symbols".toLocalize, actions: [okAction])

        }

    }

}
extension NewPasswordViewController{
    func validpassword(mypassword : String) -> Bool
    {
        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*.]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }

}

