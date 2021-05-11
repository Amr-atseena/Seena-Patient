//
//  completeSignUpStageOneViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/29/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CompleteSignStageOneViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var idType: SkyFloatingLabelTextField!
    @IBOutlet weak var financialProof: SkyFloatingLabelTextField!
    @IBOutlet weak var residenceProof: SkyFloatingLabelTextField!

    @IBOutlet weak var nextBtn: UIButton!

    var presenter: SignUpPresenterProtocol!
    var router: SignUpRouterProtocol?

    var currentTextField = SkyFloatingLabelTextField()

    let id = ["National ID","Passport"]
    let fin = ["Bank statement","HR letter"]
    let resd = ["Electricity bill","Telephone bill","Natural gas bill"]

    var idPicker = UIPickerView()
    var finPicker = UIPickerView()
    var resdPicker = UIPickerView()


    private var selectedID = "" {
        didSet {
            validatePramaters()
        }
    }

    private var selectedFin = "" {
        didSet {
            validatePramaters()
        }
    }

    private var selectedResd = "" {
        didSet {
            validatePramaters()
        }
    }
//    var selectedID  = ""
//    var selectedFin = ""
//    var selectedResd = ""


    override func viewDidLoad() {
        super.viewDidLoad()

        idPicker.delegate = self
        idPicker.dataSource = self

        finPicker.delegate = self
        finPicker.dataSource = self

        resdPicker.delegate = self
        resdPicker.dataSource = self

        idType.inputView = idPicker
        financialProof.inputView = finPicker
        residenceProof.inputView = resdPicker

        idPicker.tag = 1
        finPicker.tag = 2
        resdPicker.tag = 3

    }
    
    @IBAction func finish(_ sender: Any) {
        //        presenter.finishButtonTapped()

        //        router?.go(to: .uploadDocuments(status))


        //        navigationController?.pushViewController(uploadDocuments, animated: true)



        if (idType.text?.isEmpty == true) {
            idType.selectedLineColor = .red
            idType.lineColor = .red
            textFieldsFilled = false
        }else{
            idType.lineColor = UIColor(named: "secondaryActionText")!
            idType.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (financialProof.text?.isEmpty == true) {
            financialProof.selectedLineColor = .red
            financialProof.lineColor = .red
            textFieldsFilled = false
        }else{
            financialProof.lineColor = UIColor(named: "secondaryActionText")!
            financialProof.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }
        if (residenceProof.text?.isEmpty == true) {
            residenceProof.selectedLineColor = .red
            residenceProof.lineColor = .red
            textFieldsFilled = false
        }else{
            residenceProof.lineColor = UIColor(named: "secondaryActionText")!
            residenceProof.selectedLineColor = UIColor(named: "secondaryActionText")!
            textFieldsFilled = true
        }

        if textFieldsFilled == true {
            callMainAPI()
        }

    }

    var textFieldsFilled : Bool?
    var goCallAPI = false

    var sendProfile: Bool?
    var sendID: Bool?
    var sendFin: Bool?
    var sendRes:Bool?

    func callMainAPI() {


            APIClient().signUpsecond(iDType: selectedID, financialProofType: selectedFin, residenceProofType: selectedResd) { (res) in

                print(res.response?.otp)

                let isID = UserDefaults.standard.bool(forKey: "idType")
                let isIDLogin = UserDefaults.standard.bool(forKey: "idTypeLogin")
                let isFin = UserDefaults.standard.bool(forKey: "financialProof")
                let isFinLogin = UserDefaults.standard.bool(forKey: "financialProofLogin")
                let isProfile = UserDefaults.standard.bool(forKey: "profilePicture")
                let isProfileLogin = UserDefaults.standard.bool(forKey: "profilePictureLogin")
                let isRes = UserDefaults.standard.bool(forKey: "residenceProof")
                let isResLogin = UserDefaults.standard.bool(forKey: "residenceProofLogin")


                if isID == true || isIDLogin == true {
                    self.sendID = true
                }else{
                    self.sendID = false
                }

                if isProfile == true || isProfileLogin == true{
                    self.sendProfile = true
                }else{
                    self.sendProfile = false
                }

                if isRes == true || isResLogin == true{
                    self.sendRes = true
                }else{
                    self.sendRes = false
                }

                if isFin == true || isFinLogin == true{
                    self.sendFin = true
                }else{
                    self.sendFin = false
                }

                let status = Status(profilePicture: self.sendProfile ?? false, idType: self.sendID ?? false, financialProof: self.sendFin ?? false, residenceProof: self.sendRes ?? false)
                let router = UploadDocumentsRouter()
                let interactor = UploadDocumentsInteractor()
                let vc = UploadDocumentsVC()
                let presenter = UploadDocumentsPresenter(view: vc, interactor: interactor, router: router, status: status)

                router.viewController = vc
                interactor.presenter = presenter
                vc.presenter = presenter
                self.navigationController?.pushViewController(vc, animated: true)




            } onError: { (error) in
                print(error)
            }

    }




    func validatePramaters() {

        if selectedID == "" && selectedResd == "" && selectedFin == "" {
            nextBtn.isUserInteractionEnabled = false
            nextBtn.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }else{
            nextBtn.isUserInteractionEnabled = true
            nextBtn.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.07843137255, blue: 0.07843137255, alpha: 1)
            
        }
       

    }

    @IBAction func button(_ sender: Any) {



//        if (idType.text?.isEmpty == true) {
//            idType.selectedLineColor = .red
//            idType.lineColor = .red
//            textFieldsFilled = false
//        }else{
//            idType.lineColor = UIColor(named: "secondaryActionText")!
//            idType.selectedLineColor = UIColor(named: "secondaryActionText")!
//            textFieldsFilled = true
//        }
//        if (financialProof.text?.isEmpty == true) {
//            financialProof.selectedLineColor = .red
//            financialProof.lineColor = .red
//            textFieldsFilled = false
//        }else{
//            financialProof.lineColor = UIColor(named: "secondaryActionText")!
//            financialProof.selectedLineColor = UIColor(named: "secondaryActionText")!
//            textFieldsFilled = true
//        }
//        if (residenceProof.text?.isEmpty == true) {
//            residenceProof.selectedLineColor = .red
//            residenceProof.lineColor = .red
//            textFieldsFilled = false
//        }else{
//            residenceProof.lineColor = UIColor(named: "secondaryActionText")!
//            residenceProof.selectedLineColor = UIColor(named: "secondaryActionText")!
//            textFieldsFilled = true
//        }
//
//        if textFieldsFilled == true {
//            callMainAPI()
//        }


    }



    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        switch pickerView.tag {
        case 1:
            return id.count
        case 2:
            return fin.count
        case 3:
            return resd.count
        default:
            return 1
        }

    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        switch pickerView.tag {
        case 1:
            return id[row]
        case 2:
            return fin[row]
        case 3:
            return resd[row]
        default:
            return ""
        }

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {


        switch pickerView.tag {
        case 1:
            idType.text = id[row]
            let selectedValue = Int(idPicker.selectedRow(inComponent: 0).description)
            let increase = selectedValue! + 1

            print("ID: \(increase)")

            selectedID = "\(increase)"

        case 2:
            financialProof.text = fin[row]
            let selectedValue = Int(finPicker.selectedRow(inComponent: 0).description)
            let increase = selectedValue! + 1

            print("financialProof: \(increase)")

            selectedFin = "\(increase)"

        case 3:
            residenceProof.text = resd[row]
            let selectedValue = Int(resdPicker.selectedRow(inComponent: 0).description)
            let increase = selectedValue! + 1

            print("residenceProof: \(increase)")

            selectedResd = "\(increase)"

        default:
            return
        }


        //api call
        //        self.presenter.bankSelected(atIndex: Int(selectedValue) ?? 0)
    }

}
