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
    
    var packageList = [PackageListing]()
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
        
       if(UserDefaults.standard.object(forKey:"Userid") != nil)
       {
        GetFavList()
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : FavouriteCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! FavouriteCell
        let dic =  packageList[indexPath.row]
        var urlnew =  dic.primaryImage
        var url = "http://13.58.57.113/storage/app/" + urlnew

        cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
        cell.lbldays.text = String(dic.totalDays) + " Days " + String(dic.totalNights) + " Night"
        cell.lblname.text = dic.name
        cell.lblprice.text =  "\u{20B9}" + (dic.price)
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
            let dic =  packageList[indexPath.row]

            RemoveFavourite(id: dic.id)


        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic =  packageList[indexPath.row]

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackageDetailVC") as! PackageDetailVC
        nextViewController.package = dic
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
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
        if(UserDefaults.standard.object(forKey:"Userid") != nil)
        {
        
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/me", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: headers).responseJSONDecodable{(response:DataResponse<UserMeResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    print(resp)
                    if(resp.errorCode == 0)
                    {
                        webservices().StopSpinner()
                       self.packageList = resp.data.favourites
                        if(resp.data.favourites.count == 0)
                        {
                            
                            let alert = webservices.sharedInstance.AlertBuilder(title: "", message:"No Favourite package found")
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                        self.tblview.reloadData()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title: "", message: resp.message)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    
                    print(err.localizedDescription)
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
