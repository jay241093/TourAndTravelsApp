//
//  PopularPackgesVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/3/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
import SDWebImage
import FSPagerView
class PopularPackgesVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout ,FSPagerViewDelegate , FSPagerViewDataSource{
   
    var hotdeals = [PackageListing]()
    var featuredpackgeary = [PackageListing]()
    var popularpackgesary = [PackageListing]()
    var Offerary = [Offer]()
    var isfromlogin: Int = 0
    var banners = [String]()
    var timer :Timer?
    var count = 0
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var pagerview: FSPagerView!{
        didSet {
            self.pagerview.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
           // self.pagerview.itemSize = .zero
        }
    }
    
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    
    @IBOutlet weak var collectionview3: UICollectionView!
    
    @IBOutlet weak var collectionview4: UICollectionView!
    
    @IBOutlet weak var collecitonview5: UICollectionView!
    
    @IBOutlet weak var btn: UIButton!
    
    
    
    @IBAction func ActionSearch(_ sender: Any) {
        timer?.invalidate()

        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter?.type = .city
        self.present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     
        GetPopularPackages()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if revealViewController() != nil
        {
            btn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
pagerview.delegate = self
        pagerview.dataSource = self
if(isfromlogin == 1)
{
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewLoginVc") as! NewLoginVc
    nextViewController.FromLogin = isfromlogin
    self.navigationController?.pushViewController(nextViewController, animated: true)

        }
        

        let nibName = UINib(nibName: "PopularListCell", bundle:nil)
        let nibName1 = UINib(nibName: "BannerCell", bundle:nil)

        collectionview1.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview2.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview3.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview4.register(nibName1, forCellWithReuseIdentifier: "cell")

        setShadow(view: view1)
        setShadow(view: view2)
        setShadow(view: view3)

        let button = UIBarButtonItem(barButtonSystemItem:.search, target: self, action: #selector(PopularPackgesVC.ActionSearch))
     
        navigationController?.navigationItem.rightBarButtonItem = button

        
        // Do any additional setup after loading the view.
    }
// MARK: - Collection view delegate and datasource methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionview1)
        {
         return hotdeals.count
        }
        else if(collectionView == collectionview2)
        {
            return featuredpackgeary.count

        }
          else if(collectionView == collectionview3)
        {
            return popularpackgesary.count

        }
        else if(collectionView == collectionview4)
        {
            return Offerary.count
            
        }
      else
        {
            return 0
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    
        var size = CGSize(width: 292, height:195)
        if(collectionView == collectionview1)
        {
                let cell: PopularListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PopularListCell
          let dic = hotdeals[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "\u{20B9} \(dic.price!)"
            cell.lbloptions.text = dic.description
            var url = "http://tripgateways.co/storage/app/" + dic.primaryImage
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
            
            let rectShape = CAShapeLayer()
            rectShape.bounds =  cell.imgview.frame
            rectShape.position =  cell.imgview.center
            rectShape.path = UIBezierPath(roundedRect: cell.imgview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
            
            //Here I'm masking the textView's layer with rectShape layer
            cell.imgview.layer.mask = rectShape
            
            
            
            setShadow(view: cell.view)

            return cell

            
        }
         else if(collectionView == collectionview2)
        {
            let cell: PopularListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PopularListCell

            let dic = featuredpackgeary[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "\u{20B9} \(dic.price!)"
            cell.lbloptions.text = dic.description
            var url = "http://tripgateways.co/storage/app/" + dic.primaryImage
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
            setShadow(view: cell.view)
            let rectShape = CAShapeLayer()
            rectShape.bounds =  cell.imgview.frame
            rectShape.position =  cell.imgview.center
            rectShape.path = UIBezierPath(roundedRect: cell.imgview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
            
            //Here I'm masking the textView's layer with rectShape layer
            cell.imgview.layer.mask = rectShape
            

            return cell

        }
        else if(collectionView == collectionview3)
        {
            let cell: PopularListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PopularListCell

            let dic = popularpackgesary[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "\u{20B9} \(dic.price!)"
            cell.lbloptions.text = dic.description

            var url = "http://tripgateways.co/storage/app/" + dic.primaryImage
            setShadow(view: cell.view)
            let rectShape = CAShapeLayer()
            rectShape.bounds =  cell.imgview.frame
            rectShape.position =  cell.imgview.center
            rectShape.path = UIBezierPath(roundedRect: cell.imgview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
            
            //Here I'm masking the textView's layer with rectShape layer
            cell.imgview.layer.mask = rectShape
            

            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
            return cell

        }
        else
        {
            let cell: BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! BannerCell
            let dic = Offerary[indexPath.row]
            var url = "http://tripgateways.co/storage/app/" + dic.imagePath

            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
            let rectShape = CAShapeLayer()
            rectShape.bounds =  cell.imgview.frame
            rectShape.position =  cell.imgview.center
            rectShape.path = UIBezierPath(roundedRect: cell.imgview.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
            cell.imgview.layer.mask = rectShape
            cell.view1.layer.cornerRadius = 12.0

            cell.lblname.text = dic.title
            cell.lbldes.text = dic.description
            cell.lbltag.text = dic.code
            setShadow(view: cell.view1)
            return cell
        }
            
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      timer?.invalidate()
        if(collectionView == collectionview1)
        {
            let dic = hotdeals[indexPath.row]
            
            AddACount(id: dic.id)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackageDetailVC") as! PackageDetailVC
            nextViewController.package = dic
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        if(collectionView == collectionview2)
        {
            let dic = featuredpackgeary[indexPath.row]
            
            AddACount(id: dic.id)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackageDetailVC") as! PackageDetailVC
            nextViewController.package = dic
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        
        if(collectionView == collectionview3)
        {
            let dic = popularpackgesary[indexPath.row]
            
            AddACount(id: dic.id)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackageDetailVC") as! PackageDetailVC
            nextViewController.package = dic
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionview4)
        {
            return CGSize(width: 213, height: 250)

        }
        else
        {
        return CGSize(width: 270, height: 195)
        }
    }
    
    
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return banners.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        var url = "http://tripgateways.co/storage/app/" + (banners[index])
        
        cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "download-1"))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.backgroundView?.backgroundColor = UIColor.clear
        return cell
    }
    
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func GetPopularPackages()
    {
        if webservices().isConnectedToNetwork() == true
        {
            
            webservices().StartSpinner()
            var parameters : Parameters = [:]
            
            if(UserDefaults.standard.object(forKey:"Userid") != nil)
            {
                parameters["user_id"] = UserDefaults.standard.object(forKey:"Userid") as! Int
            }
            
        
            Alamofire.request(webservices().baseurl + "home", method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<HomeResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    print(resp)
                    if(resp.errorCode == 0)
                    {
                        webservices().StopSpinner()

                    self.hotdeals = resp.data.hotDeals
                        self.featuredpackgeary = resp.data.featuredPackages
                        self.popularpackgesary = resp.data.latestPackages
                        self.Offerary = resp.data.offers
                        self.banners = resp.data.banners
                        self.collectionview1.reloadData()
                        self.collectionview2.reloadData()
                        self.collectionview3.reloadData()
                        self.collectionview4.reloadData()
                        self.pagerview.reloadData()
                        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.updatescroll), userInfo: nil, repeats: true)


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
            NSLog("No Internet Connection")
        }
        
    }
    
    
    func AddACount(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()
            Alamofire.request(webservices().baseurl + "package/add_views", method: .post, parameters:["package_id":id] , encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    webservices().StopSpinner()
                    break
                    
                case .failure(_):
                    webservices().StopSpinner()

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
    
    @objc func updatescroll()
    {
    
     if(count >= banners.count - 1)
     {
        
        pagerview.scrollToItem(at: count, animated: true)
        count = 0


        }
        else
     {
        pagerview.scrollToItem(at: count, animated: true)
            count = count + 1
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
extension PopularPackgesVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
       CityName = ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackagesListVC") as! PackagesListVC
        nextViewController.cityname = place.name
        self.navigationController?.pushViewController(nextViewController, animated: true)

        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       
    }
    
}

