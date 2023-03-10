//
//  VerifyOTPVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit
import CoreLocation

class VerifyOTPVC: UIViewController {
    
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var tfOTP4: UITextField!
    @IBOutlet weak var tfOTP3: UITextField!
    @IBOutlet weak var tfOTP2: UITextField!
    @IBOutlet weak var tfOTP1: UITextField!
    
    var secondsRemaining = 9
    var locManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        Addtarget()
        startTimer()
        
        locManager.requestWhenInUseAuthorization()
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    print ("\(self.secondsRemaining) seconds")
                    self.btnResend.setTitle("00:0\(self.secondsRemaining)", for: .normal)
                    self.btnResend.isUserInteractionEnabled = false
                    self.secondsRemaining -= 01
                } else {
                    Timer.invalidate()
                    self.btnResend.setTitle("Resend", for: .normal)
                    self.btnResend.isUserInteractionEnabled = true
                    self.secondsRemaining = 9
                }
            }
    }
    
    func Addtarget(){
        tfOTP1.addTarget(self, action: #selector(textdidvhange(textfield:)), for: .editingChanged)
        tfOTP2.addTarget(self, action: #selector(textdidvhange(textfield:)), for: .editingChanged)
        tfOTP3.addTarget(self, action: #selector(textdidvhange(textfield:)), for: .editingChanged)
        tfOTP4.addTarget(self, action: #selector(textdidvhange(textfield:)), for: .editingChanged)
    }
    
    @objc func textdidvhange(textfield : UITextField){
        let text = textfield.text
        if text?.count == 1 {
            switch textfield{
            case tfOTP1:
                tfOTP2.becomeFirstResponder()
            case tfOTP2:
                tfOTP3.becomeFirstResponder()
            case tfOTP3:
                tfOTP4.becomeFirstResponder()
            case tfOTP4:
                tfOTP4.becomeFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textfield{
            case tfOTP1:
                tfOTP1.becomeFirstResponder()
            case tfOTP2:
                tfOTP1.becomeFirstResponder()
            case tfOTP3:
                tfOTP2.becomeFirstResponder()
            case tfOTP4:
                tfOTP3.becomeFirstResponder()
            default:
                break
            }
        }
        else {
            
        }
    }
    
    @IBAction func btnResendTapped(_ sender: UIButton) {
        self.btnResend.setTitle("00:10", for: .normal)
        startTimer()
    }
    
    
    @IBAction func btnVerifyOTPTapped(_ sender: UIButton) {
        if let getPrefData = Preference.shared.getUserDetails(){
            print(getPrefData)
            if getPrefData["user_otp"].stringValue == "\(tfOTP1.text!)\(tfOTP2.text!)\(tfOTP3.text!)\(tfOTP4.text!)"{
                Preference.shared.setUserCdId(id: getPrefData["cd_id"].intValue)
                let home = TabBarVC()
                UIApplication.shared.windows.first?.rootViewController = home
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }else{
                showAlert("Invalid OTP")
            }
        }
    }
}
