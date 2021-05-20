//
//  OTPVerifyPhoneNumberViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/4/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class OTPVerifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var firstCodeTF: UITextField!
    @IBOutlet weak var secondCodeTF: UITextField!
    @IBOutlet weak var thirdCodeTF: UITextField!
    @IBOutlet weak var fourthCodeTF: UITextField!
    @IBOutlet weak var fifthTF: UITextField!


    //    var otpFields: [UITextField] {
//       return [firstCodeTF!, secondCodeTF!, thirdCodeTF!, fourthCodeTF!]
//    }

    var phoneNum: String?

    var result : SignUpFirst?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()


    }



    func viewDesign(){
        //Main view
        firstCodeTF.delegate = self
        secondCodeTF.delegate = self
        thirdCodeTF.delegate = self
        fourthCodeTF.delegate = self

        let intLetters = phoneNum!.prefix(3)
        let endLetters = phoneNum!.suffix(2)

        let newString = intLetters + "******" + endLetters   //"+91*******21"
        phoneNumber.text = String(newString)

        firstCodeTF.becomeFirstResponder()

        fourthCodeTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        doneBtn.layer.cornerRadius = 10

    }
//    var abc : [String]! = []

    var abc : String = ""


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//        print(firstCodeTF.text!,secondCodeTF.text!,thirdCodeTF.text!,fourthCodeTF.text!)

            // On inputing value to textfield
            if ((textField.text?.count)! < 1  && string.count > 0){
                if(textField == firstCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == secondCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
//                    abc?.append(firstCodeTF.text!)
                    abc = firstCodeTF.text!
                }
                if(textField == thirdCodeTF)
                {
                    fourthCodeTF.becomeFirstResponder()
//                    abc?.append(secondCodeTF.text!)
                    abc = firstCodeTF.text! + secondCodeTF.text!
                }
                if(textField == fourthCodeTF)
                {
                    fifthTF.becomeFirstResponder()
//                    abc?.append(thirdCodeTF.text!)
//                    abc?.append(fourthCodeTF.text!)
                    abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text!

                }

                if(textField == fifthTF)
                {
//                    abc?.append(fourthCodeTF.text!)
                }


//                abc?.append(Int(fourthCodeTF.text!) ?? 0)
                textField.text = string
                print(abc)
                return false
            }
            else if ((textField.text?.count)! >= 1  && string.count == 0){
                // on deleting value from Textfield
                if(textField == secondCodeTF)
                {
                    firstCodeTF.becomeFirstResponder()
                }
                if(textField == thirdCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == fourthCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
                }
                textField.text = ""
                return false
            }
            else if ((textField.text?.count)! >= 1  )
            {
                textField.text = string
                return false
            }
            return true
        }

    @objc func textFieldDidChange(_ textField: UITextField) {
//        abc?.append(fourthCodeTF.text!)
        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!

    }


    @IBAction func done(_ sender: Any) {
//        abc?.append(fourthCodeTF.text!)
        abc = firstCodeTF.text! + secondCodeTF.text! + thirdCodeTF.text! + fourthCodeTF.text!

        print(abc)

        APIClient().postOTPSignUp(otp: abc) { (res) in
            print(res)
            if res.error?.status == false {
//                let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
//                let okAction = UIAlertAction(title: "Back".localized, style: .default) {  (_) in
//                    _ = self.navigationController?.popViewController(animated: true)
//
//                }
                let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)

                self.showAlertController(title: "Error!".toLocalize, message: (res.error?.validation)! , actions: [okAction])
                
            }else{
                self.login()
//                self.navigationController?.setViewControllers([ProfileRouter.assembleModule()], animated: true)
//            _ = self.navigationController?.popToRootViewController(animated: true)
        }
            
        } onError: { (error) in
            print(error)
        }



    }


    func login(){

        let user = result?.response?.user
        let status = result?.response?.status

        UserDefaults.standard.set(true, forKey: "Signin")

        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: "USER")

        

        if status?.financialProof == true && status?.idType == true &&
            status?.profilePicture == true && status?.residenceProof == true {
            UserDefaults.standard.set(true, forKey: "UploadSignin")
        }
        UserDefaults.standard.set(result?.error?.token, forKey: "TOKEN")



        let id = result?.response?.status?.idType
        let fin = result?.response?.status?.financialProof
        let resd = result?.response?.status?.residenceProof

        if id == false || fin == false || resd == false  {
            UserDefaults.standard.set(false, forKey: "Statuss")
        }else{
            UserDefaults.standard.set(true, forKey: "Statuss")
        }



        if status?.financialProof == true {
            UserDefaults.standard.set(true, forKey: "financialProofLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "financialProofLogin")
        }
        if status?.idType == true {
            UserDefaults.standard.set(true, forKey: "idTypeLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "idTypeLogin")
        }
        if status?.profilePicture == true {
            UserDefaults.standard.set(true, forKey: "profilePictureLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "profilePictureLogin")
        }
        if status?.residenceProof == true {
            UserDefaults.standard.set(true, forKey: "residenceProofLogin")
        }else{
            UserDefaults.standard.set(false, forKey: "residenceProofLogin")
        }



       

//        self.navigationController?.setViewControllers([Home.assembleModule()], animated: true)
        let tabBar = HomeTabBarVC()
        self.present(tabBar, animated: true)

    }

}
