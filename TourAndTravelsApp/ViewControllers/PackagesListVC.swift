
//
//  PackagesListVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/22/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class PackagesListVC: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var btnexpand: UIButton!
    var isfav = 0
    var cityname : String?
    var packagelist = [PackageListing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let display = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(FilterTapped))
     //   self.tblview.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        navigationItem.rightBarButtonItems = [display]
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          GetPackageList()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        
        
}
    
  
    // MARK: - Tableview Delegate methods
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        tblview.layer.removeAllAnimations()
//        tblheight.constant = tblview.contentSize.height
//        UIView.animate(withDuration: 0.5) {
//            self.tblview.updateConstraints()
//            self.tblview.layoutIfNeeded()
//        }
//        
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return packagelist.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PackageListCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! PackageListCell

        if(packagelist.count > 0)
      {
        setShadow(view: cell.view)
        let dic = packagelist[indexPath.row]
        
        var url = "http://13.58.57.113/storage/app/" + dic.primaryImage
        cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
        cell.lbldiscription.text! = dic.description!
        cell.btnday.setTitle(String(dic.totalNights) + "N " + String(dic.totalDays) + "D " , for: .normal)
        cell.btnday.layer.cornerRadius = 12.0
        cell.btnday.layer.borderWidth = 1
         cell.btnday.clipsToBounds = true
        cell.lblname.text = dic.name
        cell.lblprice.text = "Rs " + String(dic.price)
        cell.btnlike.addTarget(self, action: #selector(FavouriteTap), for: .touchUpInside)
        cell.btnlike.tag = indexPath.row
        cell.view.layer.cornerRadius = 10.0
        
        cell.btnlike.layer.cornerRadius = 0.5 * cell.btnlike.bounds.size.width
        cell.btnlike.clipsToBounds = true
        cell.btnlike.layer.borderColor = UIColor.orange.cgColor
        
        
        if(UserDefaults.standard.object(forKey:"islogin") != nil)
        {
             cell.btnlike.isEnabled = true
        }
       else
        {
            cell.btnlike.isEnabled = false
    
        }
        
        if(dic.isFavourite)
        {
            
           cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "like"), for: .normal)
        }
        else
        {
            cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "unlike"), for: .normal)

        }
        
       //  tblheight.constant = tblview.contentSize.height

        setShadow(view: cell.view)
        }
    return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dic = packagelist[indexPath.row]
        
        AddACount(id: dic.id)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackageDetailVC") as! PackageDetailVC
        nextViewController.package = dic
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    
    @objc func FavouriteTap(sender:UIButton)
    {
        let cell = tblview.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! PackageListCell
        let dic = packagelist[sender.tag]

        if(cell.btnlike.backgroundImage(for: .normal) == #imageLiteral(resourceName: "unlike"))
       {
        AddtoFavourite(id: dic.id)
        }
        else
       {
      RemoveFavourite(id: dic.id)
        }
    }
    
    
    func AddtoFavourite(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)


            Alamofire.request(webservices().baseurl + "customer/add_favourites", method: .post, parameters:["user_id":UserDefaults.standard.value(forKey: "Userid") as! Int, "package_id":id] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in

                switch(response.result) {
                case .success(_):


                    if let data = response.result.value{
                        
                        let dic: NSDictionary = response.result.value as! NSDictionary

                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            
                            self.GetPackageList()
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
                            
                            self.GetPackageList()
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
    
    
    
    func GetPackageList()
    {
        if webservices().isConnectedToNetwork() == true
        {
            
            var parameter :Parameters =
                [:]
            
            if(UserDefaults.standard.object(forKey:"islogin") != nil)
            {
                
                parameter = ["user_id":UserDefaults.standard.value(forKey:"Userid") as! Int]
            }
            else
            
            {
                parameter = [:]
            }
            Alamofire.request(webservices().baseurl + "packages", method: .post, parameters:parameter, encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<PackageList>) in
                switch response.result{
                    
                case .success(let resp):
                    if(resp.errorCode == 0)
                    {
                        self.packagelist = resp.data

                        if(resp.data.count == 0)
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title: "", message: "No packages found")
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                     self.tblview.delegate = self
                            self.tblview.dataSource = self

                        self.tblview.reloadData()
                         self.tblview.layoutIfNeeded()

                        }
                      }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title: "", message: resp.message)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
        }
        else
        {
            
            webservices.sharedInstance.nointernetconnection()
            NSLog("No Internet Connection")
        }
        
    }
    
    
    func AddACount(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
         
            
            Alamofire.request(webservices().baseurl + "package/add_views", method: .post, parameters:["package_id":id] , encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    
                    if let data = response.result.value{
                       
                        
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
    
    
    
    
    
    @objc func FilterTapped()
    {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
    self.navigationController?.pushViewController(nextViewController, animated: true)
    
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