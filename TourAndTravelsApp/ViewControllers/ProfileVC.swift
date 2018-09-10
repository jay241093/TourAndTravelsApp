//
//  ProfileVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/3/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var viewimage: UIView!
    @IBOutlet weak var btn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

     
        imgUser.layer.borderWidth=1.0
        imgUser.layer.masksToBounds = false
        imgUser.layer.borderColor = UIColor.white.cgColor
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2
        imgUser.clipsToBounds = true

        btnsave.layer.cornerRadius = 18.0
        if revealViewController() != nil
        {
            btn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
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
