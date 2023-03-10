//
//  AddWalletViewController.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 12/02/23.
//

import UIKit
import Razorpay
import Toaster

class AddWalletViewController: UIViewController {

    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var viewBottom: UIView!
    let razorpayKey = "rzp_live_YREZ9chVRekTNL"
    var razorpayObj : RazorpayCheckout? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBottom.roundCorners([.topLeft,.topRight], radius: 25)
    }
    
    @IBAction func btnAddMoneyTapped(_ sender: UIButton) {
        if tfAmount.text! != ""{
            DispatchQueue.main.async {
                self.openRazorpayCheckout()
            }
            
        }else{
            Toast(text: "Please enter the amount.").show()
        }
        
    }
    

}

extension AddWalletViewController{
    private func openRazorpayCheckout() {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj = RazorpayCheckout.initWithKey(razorpayKey, andDelegate: self)
        
        if let user = Preference.shared.getUserDetails()
        {
           
            //            if let url = URL(string:AppUrl.ImageUrl +  user["user_avatar"].stringValue)
            //            {
            //                imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "kpLogo"))
            //            }
            
            let options: [AnyHashable:Any] = [
                "prefill": [
                    "contact": user["user_moblie_no"].stringValue,
                    "email": user["user_email"].stringValue
                    //                "method":"wallet",
                    //                "wallet":"amazonpay"
                ],
                "image": "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
                "amount" : "\(tfAmount.text ?? "0")00",
                //"timeout":10,
                "theme": [
                    "color": "#F37254"
                ]//            "order_id": "order_B2i2MSq6STNKZV"
                // and all other options
            ]
            if let rzp = self.razorpayObj {
                rzp.open(options)
            } else {
                print("Unable to initialize")
            }
        }
        
    }
    func addAmountWallet(){
        if let user = Preference.shared.getUserDetails()
        {
        let param = ["cd_id":user["cd_id"].stringValue,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "buyer_email":"",
                     "buyer_phone":"",
                     "user_moblie_no":"",
                     "amount":"1",
                     "description":"Wallet Payment",
                     "buyer_name":"",
                     "payment_id":"",
                     "cw_id":""]

            HttpUtility.shared.post(requestUrl: AppUrl.addAmountWallet, param: param) { result in
                print(result)
                
            }
        }
        
    }
    
    func addAmountWalletFinal(paymentId:String,cwId:String,transactionId:String){
        if let user = Preference.shared.getUserDetails()
        {
            let param = ["cd_id":user["cd_id"].stringValue,
                         "key_secret":"swagstayhotel_key@2022",
                         "web_app":"IOS",
                         "token":Preference.shared.getUserFCMToken() ?? "",
                         "user_moblie_no":user["user_moblie_no"].stringValue,
                         "amount":"1",
                         "payment_id":paymentId,
                         "cw_id":cwId,
                         "transaction_id":transactionId]
            
            HttpUtility.shared.post(requestUrl: AppUrl.addAmountWalletFinal, param: param) { result in
                print(result)
                
                
            }
        }
    }
}

extension AddWalletViewController : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        addAmountWalletFinal(paymentId: payment_id, cwId: "", transactionId: "")
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

extension AddWalletViewController: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

extension AddWalletViewController {
    func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
