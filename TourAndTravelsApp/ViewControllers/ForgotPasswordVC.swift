
//
//  ForgotPasswordVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/21/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var btnsend: UIButton!
    
    @IBOutlet weak var view1: UIView!
    
    @IBAction func backtoaction(_ sender: Any) {
        
    self.navigationController?.popViewController(animated: true)
    }
    @IBAction func loginaction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        setShadow(view: view1)
        btnsend.layer.cornerRadius = 18.0
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
