//
//  PackageDetailVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/23/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import MXParallaxHeader
import SDWebImage
import FSPagerView
import  Alamofire
var globalpackage : PackageListing?

class PackageDetailVC: UIViewController , UITableViewDelegate , UITableViewDataSource ,MXParallaxHeaderDelegate, FSPagerViewDelegate , FSPagerViewDataSource {
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var viewhight: NSLayoutConstraint!
    
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var pagecontrol: FSPageControl!{
    didSet {
        print(self.package?.packageImages.count)
      
    }
    }
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var headerView: FSPagerView!{
    didSet {
    self.headerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    self.headerView.itemSize = .zero
    }
    }
    var package : PackageListing?
    
    // MARK: - IBAction Methods
    
 
    @IBAction func BookNowAction(_ sender: Any) {
        
      
        let alertController = UIAlertController(title: nil, message: "Please Login to Book Inquiry", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewLoginVc") as! NewLoginVc
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layoutIfNeeded()
        globalpackage = package
        tableView.reloadData()
        imgview.addGestureRecognizer(tap)
        self.title = package?.name
    
        tableView.parallaxHeader.view = headerView // You can set the parallax header view from the floating view
        tableView.parallaxHeader.height = 250
        tableView.parallaxHeader.mode = MXParallaxHeaderMode.fill
        tableView.parallaxHeader.delegate = self
       // var url = "http://13.58.57.113/storage/app/" + (package?.packageImages[0].path)!

    //imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))

        pagecontrol.numberOfPages = (self.package?.packageImages.count)!
        pagecontrol.contentHorizontalAlignment = .center
        pagecontrol.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        headerView.bringSubview(toFront: pagecontrol)
        let str = package?.price as! NSNumber
        lblprice.text =   "Rs \(str.stringValue)"
        
        
        // Do any additional setup after loading the view.
    }

    
    // MARK:- FSPagerView DataSource
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return (self.package?.packageImages.count)!
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        var url = "http://13.58.57.113/storage/app/" + (package?.packageImages[index].path)!
        
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.textLabel?.text = ""
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pagecontrol.currentPage != pagerView.currentIndex else {
            return
        }
        self.pagecontrol.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    // MARK: - Tableview delegate and data source methods

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        viewhight.constant = tableView.contentSize.height

        if(indexPath.row == 0)
        {
            
        let cell:PackageDetailCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  PackageDetailCell
        cell.selectionStyle = .none
            cell.lblCityStays.text = ""
            
            for city in (package?.allCities)!
            {
                cell.lblCityStays.text =  cell.lblCityStays.text! + city.city + " (\(city.stayNights) N)"
                
            }
            
        cell.lbllocation.text = package?.allCities[0].city
       cell.lblexpireOn.text = package?.endDate
        setShadow(view: cell.view1)
        setShadow(view: cell.view2)
            setShadow(view: cell.view3)
           cell.lblDays.layer.masksToBounds = true

            cell.lblDays.layer.cornerRadius = 12.0
        cell.lblDays.layer.borderWidth = 1.0
 cell.lblDays.layer.borderColor = UIColor.white.cgColor

   cell.lblname.text = package?.name
     cell.lbldes.text = package?.description
            
            
        let day = package?.totalDays as! NSNumber
        let night = package?.totalNights as! NSNumber

            cell.lblDays.text =  night.stringValue + " N" + day.stringValue + " D " 
     let num = package?.price as! NSNumber
   cell.lblprice.text =  "Rs." + num.stringValue
            cell.btnflight.addTarget(self, action: #selector(PackageDetailVC.showflight), for: .touchUpInside)
            cell.btnhotel.addTarget(self, action: #selector(PackageDetailVC.showHotel), for: .touchUpInside)
            if(package?.isFavourite)!
            {
                
                cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "heart-solid (1)"), for: .normal)
            }
            else
            {
                cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "heart-regular-1"), for: .normal)
                
            }
             cell.btnlike.tag = indexPath.row
            
            cell.btnlike.addTarget(self, action: #selector(LikeAction), for: .touchUpInside)
            cell.lblDays.backgroundColor = UIColor(patternImage: UIImage(named: "orange")!)

        return cell
        }
        else if(indexPath.row == 1)
         {
            let cell:SearchCityCell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as!  SearchCityCell
            let num = package?.totalDays as! NSNumber
            cell.lblname?.text = "Internity - \(num.stringValue) Days"
            cell.selectionStyle = .none

            return cell

         }
            
        else if(indexPath.row == 2)
        {
            
            let cell:DetailviewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as!  DetailviewCell
            cell.selectionStyle = .none

            cell.imgview.layer.borderWidth=1.0
            cell.imgview.layer.masksToBounds = false
            cell.imgview.layer.borderColor = UIColor.white.cgColor
            cell.imgview.layer.cornerRadius =  cell.imgview.frame.size.height/2
            
            cell.lblname.text = package?.packageIty[0].title
            cell.lbldes.text = package?.packageIty[0].text
            var url = "http://13.58.57.113/storage/app/" + (package?.packageIty[0].imagePath)!
            
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
            cell.imgview.clipsToBounds = true
            return cell

        }
            
        else if(indexPath.row == 3)
        {
          
            let cell:DetailviewCell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as!  DetailviewCell
            cell.imgview.layer.borderWidth=1.0
            cell.imgview.layer.masksToBounds = false
            cell.imgview.layer.borderColor = UIColor.white.cgColor
            cell.selectionStyle = .none

            var url = "http://13.58.57.113/storage/app/" + (package?.packageIty[1].imagePath)!
            
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
            
            cell.imgview.layer.cornerRadius =  cell.imgview.frame.size.height/2
            cell.lblname.text = package?.packageIty[1].title
            cell.lbldes.text = package?.packageIty[1].text

            cell.imgview.clipsToBounds = true
            return cell
            
        }
        else if(indexPath.row == 4)
       
        {
            let cell:SearchCityCell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as!  SearchCityCell
            
            cell.selectionStyle = .none
           return cell
        }
        
     else if(indexPath.row == 5)
        {
            let cell:HotelListCell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as!  HotelListCell
            cell.selectionStyle = .none

            return cell
            
        }
        else if(indexPath.row == 6)
        {
            let cell:SearchCityCell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as!  SearchCityCell
            cell.selectionStyle = .none

            return cell
        }
        else if(indexPath.row == 7)
        {
        
            let cell:FlightCell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath) as!  FlightCell
            cell.selectionStyle = .none

            setShadow(view: cell.view)
            return cell
        }
        else if(indexPath.row == 8)
        {
            
            let cell:FlightCell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath) as!  FlightCell
            cell.selectionStyle = .none

            setShadow(view: cell.view)
            return cell
        }
       else
        {
            let cell:SearchCityCell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath) as!  SearchCityCell
            setShadow(view: cell.voew)
            let htmlData = NSString(string: (package?.cancellationPolicy)!).data(using: String.Encoding.unicode.rawValue)
            cell.selectionStyle = .none

            let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
            
            let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
            
            cell.lbldes.text = attributedString.string
            cell.btnreadmore.tag = indexPath.row
            // cell.lbldes.sizeToFit()
            cell.btnreadmore.addTarget(self, action: #selector(readmore), for: .touchUpInside)
            return cell

        }
        
    }
    @objc func readmore(sender:UIButton)
    {
        let htmlData = NSString(string: (package?.cancellationPolicy)!).data(using: String.Encoding.unicode.rawValue)
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        
        let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
        
        let alertController = UIAlertController(title: "Cancellation Policy", message:attributedString.string, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
       
        // Add the actions
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 3 || indexPath.row == 2)
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FulliternityVC") as! FulliternityVC
            nextViewController.package = package
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        
    }
    
    @objc func showflight(sender:UIButton)
    {
        
        
        tableView.scrollToRow(at: IndexPath(row: 8, section: 0), at:.bottom, animated: true)
      
    }
    
    
    
    @objc func showHotel(sender: UIButton)
    {
        tableView.scrollToRow(at: IndexPath(row: 5, section: 0), at:.bottom, animated: true)

        
    }
    
    @objc func LikeAction(sender:UIButton)
    {
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! PackageDetailCell
      
        if(cell.btnlike.backgroundImage(for: .normal) == #imageLiteral(resourceName: "heart-regular-1"))
        {
            AddtoFavourite(id:(package?.id)!)
            cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "heart-solid (1)"), for: .normal)
            package?.isFavourite = true
        }
        else
        {
            RemoveFavourite(id: (package?.id)!)
            cell.btnlike.setBackgroundImage(#imageLiteral(resourceName: "heart-regular-1"), for: .normal)
            package?.isFavourite = false


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
    
    func BookNow(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/booking", method: .post, parameters:["user_id":UserDefaults.standard.value(forKey: "Userid") as! Int, "package_id":id] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    
                    if let data = response.result.value{
                        
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            
                            
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
