//
//  OTPForgetPasswordViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/2/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class OTPForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UILabel!
    @IBOutlet weak var firstCodeTF: UITextField!
    @IBOutlet weak var secondCodeTF: UITextField!
    @IBOutlet weak var thirdCodeTF: UITextField!
    @IBOutlet weak var fourthCodeTF: UITextField!
    
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

        doneBtn.layer.cornerRadius = 10

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // On inputing value to textfield
            if ((textField.text?.count)! < 1  && string.count > 0){
                if(textField == firstCodeTF)
                {
                    secondCodeTF.becomeFirstResponder()
                }
                if(textField == secondCodeTF)
                {
                    thirdCodeTF.becomeFirstResponder()
                }
                if(textField == thirdCodeTF)
                {
                    fourthCodeTF.becomeFirstResponder()
                }

                textField.text = string
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

    @IBAction func done(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetPassword", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewPasswordViewController") as? NewPasswordViewController
        newViewController!.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newViewController!, animated: true)
    }

}
