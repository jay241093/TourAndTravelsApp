

//
//  SideMenuVc.swift
//  PlanMyTrip
//
//  Created by Ravi Dubey on 8/21/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class SideMenuVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var sections = sectionsData

    @IBOutlet weak var tblview: UITableView!
var sidemenuname = ["Profile" , "My Shortlists"]
    var cells = ["cell2","cell","cell1"]

    @IBOutlet weak var lblname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.object(forKey:"islogin") != nil)
        {
            let name = UserDefaults.standard.value(forKey:"first") as! String
            let lname = UserDefaults.standard.value(forKey:"Last") as! String

            lblname.text = name + " " + lname
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseidentifier =  cells[indexPath.row]
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:reuseidentifier, for: indexPath)
       
        //cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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

//
// MARK: - Section Header Delegate
//
