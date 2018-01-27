//
//  AboutVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-25.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI


class AboutVC: UIViewController {
    

    @IBAction func rateButton(_ sender: Any) {
        SKStoreReviewController.requestReview()
    }
    
    @IBAction func youtubeButton(_ sender: Any) {
        openUrl(urlLink: "https://www.youtube.com/c/iOSDeveloperUla")
    }
    
    @IBAction func twitterButton(_ sender: Any) {
        openUrl(urlLink: "https://twitter.com/daratsiuk")
        
    }
    
    @IBAction func emailButton(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            showMailError()}
    }
    
    
    func openUrl(urlLink: String){
        if let url  = NSURL(string: urlLink){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension AboutVC : MFMailComposeViewControllerDelegate {
    
    func configureMailController()-> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["uladzislau.daratsiuk@gmail.com"])
        mailComposerVC.setSubject("For Developer ")
        mailComposerVC.setMessageBody("Hi Ula,", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError(){
        
        let sendMailErrorAlert = UIAlertController (title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title:"OK",style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil )
    }
    
}
