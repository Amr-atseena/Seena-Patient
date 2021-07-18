//
//  ScanQRViewController.swift
//  Seena Patient
//
//  Created by RKAnjel on 4/26/21.
//  Copyright © 2021 RKAnjel. All rights reserved.
//

import UIKit
import AVFoundation


class ScanQRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!

    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    var theCode : String?
    var shouldGo : Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10

        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }

        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
            
        } else {
            failed()
            return
        }

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = cameraView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.addSublayer(previewLayer)

        captureSession.startRunning()
        viewDesign()

    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }


    func viewDesign(){
        //Main view
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = true
        mainView.layer.maskedCorners = [ .layerMaxXMinYCorner,.layerMinXMinYCorner]
    }



    func failed() {
        let ac = UIAlertController(title: "Scanning not supported".toLocalize, message: "Your device does not support scanning a code from an item. Please use a device with a camera.".toLocalize, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK".toLocalize, style: .default))
        present(ac, animated: true)
        captureSession = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }


    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()

        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }

//        dismiss(animated: true)
//        UserDefaults.standard.setValue(self.theCode, forKey: "QRCode")


//        let amo = UserDefaults.standard.string(forKey: "amount")
//        let pay = UserDefaults.standard.string(forKey: "installmentsPayment")
////        let docId = UserDefaults.standard.string(forKey: "QRCode")
//        let inst = UserDefaults.standard.integer(forKey: "installment_plans_ID")
//
//        APIClient().payForDoctor(amount: amo!, paymentMethod: pay!, doctorID: self.theCode!, inst: inst) { (res) in
//            print(res.response.success)
//
//            UserDefaults.standard.set(res.response.paymentID, forKey: "PAYMENTID")
//
////            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
////            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
////            newViewController!.modalPresentationStyle = .fullScreen
////            self.present(newViewController!, animated: true, completion: nil)
//
            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as? PaymentMethodsViewController
            newViewController?.docId = Int(self.theCode!)
            newViewController!.modalPresentationStyle = .fullScreen
            self.present(newViewController!, animated: true, completion: nil)
//
//            self.shouldGo = true
//
//
//        } onError: { (error) in
//            self.showAlertController(title: "Error!", message: error, actions: [])
//            self.shouldGo = false
//        }

        
    }

    func found(code: String) {
        let dateFormatter : DateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let interval = date.timeIntervalSince1970

        print("Code is: \(code), Time is: \(dateString)")

        theCode = code
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    @IBAction func next(_ sender: Any) {
        if shouldGo == true {
//            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "OTPViewController") as? OTPViewController
//            newViewController!.modalPresentationStyle = .fullScreen
//            self.present(newViewController!, animated: true, completion: nil)

            let storyBoard: UIStoryboard = UIStoryboard(name: "NewPayment", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as? PaymentMethodsViewController
            newViewController!.modalPresentationStyle = .fullScreen
            self.present(newViewController!, animated: true, completion: nil)
        }else{
            showAlertController(title: "Error!".toLocalize, message: "Check QR code correctly".toLocalize, actions: [])
        }


    }

}


extension ScanQRViewController: UIGestureRecognizerDelegate {
func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if gestureRecognizer.isEqual(navigationController?.interactivePopGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    return false
}
}
