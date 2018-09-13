

//
//  SideMenuVc.swift
//  PlanMyTrip
//
//  Created by Ravi Dubey on 8/21/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class SideMenuVc: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblview: UITableView!
var sidemenuname = ["Profile" , "My Shortlists"]
    var cells = ["cell2","cell","cell1","cell3","cell4","cell5","cell6"]

    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.separatorColor = UIColor.clear
        imgview.layer.borderWidth=1.0
        imgview.layer.masksToBounds = false
        imgview.layer.borderColor = UIColor.white.cgColor
        imgview.layer.cornerRadius = imgview.frame.size.height/2
        imgview.clipsToBounds = true
    
    }
    override func viewWillAppear(_ animated: Bool) {
        if(UserDefaults.standard.object(forKey:"Userid") != nil)
        {
            let name = UserDefaults.standard.value(forKey:"first") as! String
            let lname = UserDefaults.standard.value(forKey:"Last") as! String
            
            lblname.text = name + " " + lname
            self.tblview.reloadData()
            
            if(UserDefaults.standard.object(forKey:"Profilepic") != nil)
            {
                var urlnew =  UserDefaults.standard.value(forKey:"Profilepic") as! String
                var url = "http://13.58.57.113/storage/app/" + urlnew

               imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))

            }
        }
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
    
        //cell.detailLabel.text = item.detail
    if(indexPath.row == 1 || indexPath.row == 2)
    {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:reuseidentifier, for: indexPath)

       if(UserDefaults.standard.object(forKey:"Userid") != nil)
       {
        cell.isUserInteractionEnabled = true

        }
        else
       {
        cell.isUserInteractionEnabled = false
        
        }
        return cell
    }
   
      else if(indexPath.row == 6)
        {
            let cell: SearchCityCell = tableView.dequeueReusableCell(withIdentifier:reuseidentifier, for: indexPath) as! SearchCityCell

            if(UserDefaults.standard.object(forKey:"Userid") != nil)
            {
                cell.lblsidemenu.text = "LogOut"
                cell.imgview.image = UIImage(named:"sign-in-alt-solid")
            }
            else
            {
                cell.lblsidemenu.text = "Login"
                cell.imgview.image = UIImage(named:"sign-in-alt-solid")

            }
            return cell
        }
       else
    {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:reuseidentifier, for: indexPath)
        return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      if(indexPath.row == 4)
      {
        let url = URL(string: "itms://itunes.apple.com")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                print("Open url : \(success)")
            })
        }
    }
        
        
    if(indexPath.row == 3)
    {  let text = "TripGateways://"
    
    let shareAll = [text]
    let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view
    self.present(activityViewController, animated: true, completion: nil)
    
    }
        if(indexPath.row == 6)
        {
            if(UserDefaults.standard.object(forKey:"Userid") != nil)
            {
                var refreshAlert = UIAlertController(title: "Logout", message: "Are you sure want to log out?", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    print("Handle Ok logic here")
                    let cell =  tableView.cellForRow(at:indexPath) as! SearchCityCell
                    cell.lblsidemenu.text = "Login"
                    UserDefaults.standard.removeObject(forKey:"first")
                    UserDefaults.standard.removeObject(forKey:"Last")
                    UserDefaults.standard.removeObject(forKey:"email")
                    UserDefaults.standard.removeObject(forKey:"mobile")
                    UserDefaults.standard.removeObject(forKey:"token")
                    UserDefaults.standard.removeObject(forKey:"Userid")
                    UserDefaults.standard.synchronize()
                    self.lblname.text = "User Name"
                    self.tblview.reloadData()
                    

                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)

            }
            else
            {
                var tar = storyboard?.instantiateViewController(withIdentifier: "PopularPackgesVC") as? PopularPackgesVC
                tar?.isfromlogin = 1
                var navController: UINavigationController? = nil
                if let aTar = tar {
                    navController = UINavigationController(rootViewController: aTar)
                }
                navController?.setViewControllers([tar!], animated: true)
                
                revealViewController().frontViewController = navController
                revealViewController().setFrontViewPosition(.left, animated: true)

                
            }
        }
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
