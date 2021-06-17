//
//  FirstSignUpViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/4/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FirstSignUpViewController: UIViewController {
    @IBOutlet weak var email: SkyFloatingLabelTextField!
    @IBOutlet weak var phone: SkyFloatingLabelTextField!
    @IBOutlet weak var firstName: SkyFloatingLabelTextField!
    @IBOutlet weak var lastName: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPass: SkyFloatingLabelTextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var birthDate: SkyFloatingLabelTextField!
    @IBOutlet weak var loadingIndictor: UIActivityIndicatorView!

    var selectedDate = ""
    let datePicker = UIDatePicker()
    let progressHUD = ProgressHUD(text: "")


    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePicker()

        lastName.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        confirmPass.addTarget(self, action: #selector(textDidBeginEditing), for: .editingDidEnd)

    }

    @objc func textDidBeginEditing(sender:UITextField) -> Void
    {
        textFieldsSetup()
    }

    func textFieldsSetup(){
        if password.text?.isEmpty == true && confirmPass.text?.isEmpty == true{
            print("Write your passwords")
        }
        else{
            if password.text == confirmPass.text {
                print("Matching")
                texfieldImage(textField: password, imageName: "right")
                texfieldImage(textField: confirmPass, imageName: "right")
            }else{
                print("Not matching")
                texfieldImage(textField: password, imageName: "right")
                texfieldImage(textField: confirmPass, imageName: "wrong")
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

    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)".replacedArabicDigitsWithEnglish)
        }
    }


    func setDatePicker() {
        //Format Date
        datePicker.datePickerMode = .date

        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done".toLocalize, style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel".toLocalize, style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        birthDate.inputAccessoryView = toolbar
        birthDate.inputView = datePicker
    }

    @objc func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        birthDate.text = formatter.string(from: datePicker.date).replacedArabicDigitsWithEnglish
        selectedDate = formatter.string(from: datePicker.date).replacedArabicDigitsWithEnglish
        self.setBirthDate(selectedDate)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }


    //    func dateSelected(_ date: Date) {
    //        let dateFormater = DateFormatter()
    //        dateFormater.dateFormat = "yyyy-MM-dd"
    //        selectedDate = dateFormater.string(from: date)
    //        self.setBirthDate(selectedDate)
    //    }
    func setBirthDate(_ date: String) {
        birthDate.text = date
    }

    var goCallAPI = false

    func emailAndPassValidation(){
        self.progressHUD.removeFromSuperview()

        let email = isValidEmail(self.email.text!)
        let password = validpassword(mypassword: self.password.text!) //get text Field data & checked through the function

        if email == true  {

            if password == true{
                goCallAPI = true
            }

        }else{
            let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
            showAlertController(title: "Email validation!".toLocalize, message: "E-mail must contain only latin letters, numbers, '@' and '.'".toLocalize, actions: [okAction])

            goCallAPI = false
        }

        //        let password = validpassword(mypassword: self.password.text!) //get text Field data & checked through the function
        if(password == true){
            self.progressHUD.removeFromSuperview()

            print("Valid Password")  //Use to Alert Msg Box
        }else
        {
            let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
            showAlertController(title: "Password validation!".toLocalize, message: "Password should be more than 8 characters, including numbers, uppercase letter, and symbols".toLocalize, actions: [okAction])

            goCallAPI = false
        }
    }


    weak var presenter: SignInOutputInteractorProtocol?


    func mainAPI(){

        if goCallAPI == true{

            let regUser = UserInfo(firstName: firstName.text!, lastName: lastName.text, password: password.text!, phone: phone.text!.replacedArabicDigitsWithEnglish, email: email.text, birthdate: selectedDate)

            APIClient().signUpFirst(userInfo: regUser) {(res) in
                self.progressHUD.removeFromSuperview()

                self.loadingIndictor.isHidden = true
                self.loadingIndictor.stopAnimating()

                print(res.error?.token)




                UserDefaults.standard.setValue(res.response?.status?.idType, forKey: "keyRegistered")
                UserDefaults.standard.set(res.error?.token, forKey: "TOKEN")


                if res.error?.code == 400{
                    self.loadingIndictor.isHidden = true
                    self.loadingIndictor.stopAnimating()

                    self.showAlertController(title: "Error!".toLocalize, message: (res.error?.validation)!, actions: [])
                }else{

                let storyBoard: UIStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVerifyPhoneNumberViewController") as? OTPVerifyPhoneNumberViewController
                newViewController!.modalPresentationStyle = .fullScreen
                    newViewController?.phoneNum = res.response?.user?.phone
                    newViewController?.result = res
                self.navigationController?.pushViewController(newViewController!, animated: true)
                }

            } onError: { (error) in
                self.progressHUD.removeFromSuperview()

                print(error)
                let okAction = UIAlertAction(title: "OK".localized, style: .default, handler: nil)

                self.showAlertController(title: "Error!".toLocalize, message: error, actions: [okAction])

            }
        }else{}
    }

    var textFieldsFilled : Bool?

    @IBAction func finish(_ sender: Any) {
        
        self.view.addSubview(progressHUD)
        
        emailAndPassValidation()

        if (firstName.text?.isEmpty == true) {
            firstName.selectedLineColor = .red
            firstName.lineColor = .red
            textFieldsFilled = false
        }else{
            firstName.lineColor = UIColor(named: "secondaryActionText")!
            firstName.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (lastName.text?.isEmpty == true) {
            lastName.selectedLineColor = .red
            lastName.lineColor = .red
            textFieldsFilled = false
        }else{
            lastName.lineColor = UIColor(named: "secondaryActionText")!
            lastName.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (email.text?.isEmpty == true) {
            email.selectedLineColor = .red
            email.lineColor = .red
            textFieldsFilled = false
        }else{
            email.lineColor = UIColor(named: "secondaryActionText")!
            email.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (phone.text?.isEmpty == true) {
            phone.selectedLineColor = .red
            phone.lineColor = .red
            textFieldsFilled = false
        }else{
            phone.lineColor = UIColor(named: "secondaryActionText")!
            phone.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (password.text?.isEmpty == true) {
            password.selectedLineColor = .red
            password.lineColor = .red
            textFieldsFilled = false
        }else{
            password.lineColor = UIColor(named: "secondaryActionText")!
            password.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (confirmPass.text?.isEmpty == true) {
            confirmPass.selectedLineColor = .red
            confirmPass.lineColor = .red
            textFieldsFilled = false
        }else{
            confirmPass.lineColor = UIColor(named: "secondaryActionText")!
            confirmPass.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (birthDate.text?.isEmpty == true) {
            birthDate.selectedLineColor = .red
            birthDate.lineColor = .red
            textFieldsFilled = false
        }else{
            birthDate.lineColor = UIColor(named: "secondaryActionText")!
            birthDate.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }

        if textFieldsFilled == true {
            
            mainAPI()
        }


    }


}


extension FirstSignUpViewController{
    func validpassword(mypassword : String) -> Bool
    {
        let passwordreg =  ("(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z])(?=.*[@#$%^&*.]).{8,}")
        let passwordtesting = NSPredicate(format: "SELF MATCHES %@", passwordreg)
        return passwordtesting.evaluate(with: mypassword)
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}


public extension String {

public var replacedArabicDigitsWithEnglish: String {
    var str = self
    let map = ["٠": "0",
               "١": "1",
               "٢": "2",
               "٣": "3",
               "٤": "4",
               "٥": "5",
               "٦": "6",
               "٧": "7",
               "٨": "8",
               "٩": "9"]
    map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
    return str
}
}
