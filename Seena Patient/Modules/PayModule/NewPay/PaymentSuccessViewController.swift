//
//  PaymentSuccessViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var stackContainerView: UIView!
    @IBOutlet weak var clinicImage: UIImageView!
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var doneBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()

        let savedAmount = UserDefaults.standard.string(forKey: "amount")
        let period = UserDefaults.standard.string(forKey: "installmentPeriod")
        let name = UserDefaults.standard.string(forKey: "doctorName")
        let datee = UserDefaults.standard.string(forKey: "paymentDate")
        let imagee = UserDefaults.standard.string(forKey: "doctorImage")

        amount.text = "EGP \(savedAmount ?? "")"
        duration.text = "\(period ?? "") months"
        date.text = datee
        clinicName.text = name

        let url = URL(string: imagee ?? "")
        clinicImage.kf.setImage(with: url)
    }


    func viewDesign(){
        //Main view
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]


        // corner radius
        stackContainerView.layer.cornerRadius = 10

        // border
//        blueView.layer.borderWidth = 1.0
//        blueView.layer.borderColor = UIColor.black.cgColor

        // shadow
        stackContainerView.layer.shadowColor = UIColor.black.cgColor
        stackContainerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        stackContainerView.layer.shadowOpacity = 0.7
        stackContainerView.layer.shadowRadius = 4.0
    }


    @IBAction func done(_ sender: Any) {

        UserDefaults.standard.removeObject(forKey: "amount")
        UserDefaults.standard.removeObject(forKey: "installmentPeriod")
        UserDefaults.standard.removeObject(forKey: "installmentsPayment")
//        UserDefaults.standard.removeObject(forKey: "QRCode")
        UserDefaults.standard.removeObject(forKey: "installment_plans_ID")
        UserDefaults.standard.removeObject(forKey: "doctorName")
        UserDefaults.standard.removeObject(forKey: "paymentDate")
        UserDefaults.standard.removeObject(forKey: "doctorImage")

        let controller = HomeTabBarVC()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)


    }


    private func homeModule() -> UIViewController {
        let home = UINavigationController(rootViewController: HomeRouter.assembleModule())
        self.present(home, animated: true, completion: nil)
        return home
    }
}
