//
//  FavouriteLstVc.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/8/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class FavouriteLstVc: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    
    var favary = NSMutableArray()
    @IBOutlet weak var menu: UIButton!
    
    @IBOutlet weak var tblview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblview.delegate = self
        tblview.dataSource = self

        if revealViewController() != nil
        {
            menu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        GetFavList()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FavouriteCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! FavouriteCell
        let dic = favary.object(at: indexPath.row) as! NSDictionary
        var urlnew =  dic.value(forKey:"primary_image") as! String
        var url = "http://13.58.57.113/storage/app/" + urlnew

        cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
        cell.lbldays.text = String(dic.value(forKey: "total_days") as! Int) + " Days " + String(dic.value(forKey: "total_nights") as! Int) + " Night"
        cell.lblname.text = dic.value(forKey: "name") as! String
        cell.lblprice.text =  "Rs " + (dic.value(forKey:"price") as! NSNumber).stringValue
        setShadow(view: cell.view)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let dic = favary.object(at: indexPath.row) as! NSDictionary
            
            RemoveFavourite(id: dic.value(forKey:"id") as! Int)


        }
    }
    
    
    
    func RemoveFavourite(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/remove_favourites", method: .post, parameters:["user_id":UserDefaults.standard.value(forKey: "Userid") as! Int, "package_id":id] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    
                    if let data = response.result.value{
                        
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            self.GetFavList()
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message: dic.value(forKey:"message") as! String)
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message: dic.value(forKey:"message") as! String)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    break
                    
                case .failure(_):
                    
                    print(response.result.error)
                    break
                    
                }
            }
            
        }
        else
        {
            webservices.sharedInstance.nointernetconnection()
        }
        
    }
    
    
    func GetFavList()
    {
        if(UserDefaults.standard.object(forKey:"islogin") != nil)
        {
        
        if webservices().isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/me", method: .post, parameters:[:] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    
                    if let data = response.result.value{
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                       
                        let ary = (dic.value(forKey:"data") as! NSDictionary).value(forKey: "favourites") as! NSArray
                      if(ary.count != 0)
                      {
                        self.favary = ary.mutableCopy() as! NSMutableArray
                        self.tblview.reloadData()
                        }
                        else
                      {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message: "No Favourite Packges Found")
                        self.present(alert, animated: true, completion: nil)
                        
                        }
                    }
                    break
                    
                case .failure(_):
                    
                    print(response.result.error)
                    break
                    
                }
            }
            
        }
        else
        {
            webservices.sharedInstance.nointernetconnection()
        }
        }
    
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
