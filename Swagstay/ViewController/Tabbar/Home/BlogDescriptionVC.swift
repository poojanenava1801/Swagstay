//
//  BlogDescriptionVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 08/03/23.
//

import UIKit
import WebKit
import SwiftyJSON

class BlogDescriptionVC: UIViewController ,WKNavigationDelegate{

    @IBOutlet weak var viewShare: UIView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var weViewHeight: NSLayoutConstraint!
    
    var dictBolgs = JSON().dictionaryValue
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        webView.navigationDelegate = self
        webView.scrollView.backgroundColor = .white
        lblTitle.text = dictBolgs["title_name"]?.stringValue
        lblDate.text = dictBolgs["entry_date"]?.stringValue
        lblTagLine.text = dictBolgs["tag_line"]?.stringValue
        if let imgUrl = URL(string:dictBolgs["banner_image"]?.stringValue ?? ""){
            imgHotel.sd_setImage(with: imgUrl)
        }
        viewShare.addTap {
            // Setting description
                let firstActivityItem = "Check Out this Hotel In Swagstay"

                // Setting url
            let secondActivityItem : URL = URL(string:self.dictBolgs["url_link"]?.stringValue ?? "")!
                
                // If you want to use an image
                let image : UIImage = UIImage(named: "logo_small")!
                let activityViewController : UIActivityViewController = UIActivityViewController(
                    activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (self.viewShare)
                
                // This line remove the arrow of the popover to show in iPad
                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                
                // Pre-configuring activity items
                activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
                ] as? UIActivityItemsConfigurationReading
                
                // Anything you want to exclude
                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.postToWeibo,
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo,
                    UIActivity.ActivityType.postToFacebook
                ]
                
                activityViewController.isModalInPresentation = true
                self.present(activityViewController, animated: true, completion: nil)
        }
        
        self.webView.loadHTMLStringWithMagic(content: dictBolgs["description"]?.stringValue ?? "", baseURL: nil)
    }
    
    
    
    
    
    //Equivalent of webViewDidFinishLoad:
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           print("didFinish - webView.url: \(String(describing: webView.url?.description))")

           webView.frame.size.height = 1
           webView.frame.size = webView.sizeThatFits(.zero)
           webView.scrollView.isScrollEnabled=false
           DispatchQueue.main.asyncAfter(deadline: .now()+0.25) {
               self.weViewHeight.constant = webView.scrollView.contentSize.height
           }
           
       }


}


extension WKWebView {

    /// load HTML String same font like the UIWebview
    ///
    //// - Parameters:
    ///   - content: HTML content which we need to load in the webview.
    ///   - baseURL: Content base url. It is optional.
    func loadHTMLStringWithMagic(content:String,baseURL:URL?){
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        loadHTMLString(headerString + content, baseURL: baseURL)
    }
}
