//
//  ApplicationStatusViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 5/2/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class ApplicationStatusViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var actionLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var statusKeywordLabel: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()

        statusKeywordLabel.font = DesignSystem.Typography.heading.font
        viewDesign()

    }
    

    func viewDesign(){
        //Main view
        headerView.layer.cornerRadius = 50
        headerView.layer.masksToBounds = true
        headerView.layer.maskedCorners = [ .layerMaxXMaxYCorner]

        // Next button

        nextBtn.layer.cornerRadius = 10

        cornerAndShadow(myView: reasonView)
        cornerAndShadow(myView: actionView)
       
    }

    func cornerAndShadow(myView : UIView){
        // corner radius
        myView.layer.cornerRadius = 10

        // border
//        myView.layer.borderWidth = 1.0
//        myView.layer.borderColor = UIColor.black.cgColor

        // shadow
        myView.layer.shadowColor = UIColor.black.cgColor
        myView.layer.shadowOffset = CGSize(width: 3, height: 3)
        myView.layer.shadowOpacity = 0.7
        myView.layer.shadowRadius = 4.0

        myView.layer.masksToBounds = true
        myView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner ,.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    var sendProfile: Bool?
    var sendID: Bool?
    var sendFin: Bool?
    var sendRes:Bool?

    @IBAction func next(_ sender: Any) {
        // h check mn eldata elly htrg3 a m3 mrfo3 w ashel el cach bta3o w aft7o
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
    }
}


