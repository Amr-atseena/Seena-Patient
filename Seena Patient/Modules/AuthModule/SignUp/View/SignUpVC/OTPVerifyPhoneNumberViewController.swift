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
            if res.error?.validation == "not authorized"{
                self.showAlertController(title: "Error", message: (res.error?.validation)! , actions: [])
            }else{
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
            
        } onError: { (error) in
            print(error)
        }



    }


    

}
