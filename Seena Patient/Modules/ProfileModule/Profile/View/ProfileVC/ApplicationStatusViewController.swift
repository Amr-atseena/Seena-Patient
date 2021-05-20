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

    @IBAction func next(_ sender: Any) {
    }
}


