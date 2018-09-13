//
//  ContactUsVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/13/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import WebKit
class ContactUsVC: UIViewController {
    
    @IBOutlet weak var btnmenu: UIButton!
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.loadRequest(URLRequest(url: URL(string:"http://tripgateways.co/contact")!))

        if revealViewController() != nil
        {
            btnmenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
