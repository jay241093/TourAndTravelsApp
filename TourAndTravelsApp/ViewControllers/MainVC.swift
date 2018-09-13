//
//  MainVC.swift
//  PlanMyTrip
//
//  Created by Ravi Dubey on 8/21/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
func setShadow(view: UIView)
{
    view.layer.masksToBounds = false
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOpacity = 0.5
    view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
    view.layer.shadowRadius = 4
}
class MainVC: UIViewController {

    @IBOutlet weak var segement: UISegmentedControl!
    
// MARK: - IBAction Methods
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
