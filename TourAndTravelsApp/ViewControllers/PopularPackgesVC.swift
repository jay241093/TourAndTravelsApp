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
class PopularPackgesVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    var hotdeals = [PackageListing]()
    var featuredpackgeary = [PackageListing]()
    var popularpackgesary = [PackageListing]()

    
    
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    
    @IBOutlet weak var collectionview3: UICollectionView!
    
    @IBOutlet weak var collectionview4: UICollectionView!
    
    @IBOutlet weak var collecitonview5: UICollectionView!
    
    @IBOutlet weak var btn: UIButton!
    
    
    
    @IBAction func ActionSearch(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter?.type = .city
        autocompleteController.tintColor = UIColor.gray
        let navigationController = UINavigationController(rootViewController: autocompleteController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

GetPopularPackages()
        let nibName = UINib(nibName: "PopularListCell", bundle:nil)
        
        collectionview1.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview2.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview3.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview4.register(nibName, forCellWithReuseIdentifier: "cell")
        collecitonview5.register(nibName, forCellWithReuseIdentifier: "cell")

        setShadow(view: view1)
        setShadow(view: view2)
        setShadow(view: view3)

        setShadow(view: view4)

        setShadow(view: view5)
        let button = UIBarButtonItem(barButtonSystemItem:.search, target: self, action: #selector(PopularPackgesVC.ActionSearch))
     
        navigationController?.navigationItem.rightBarButtonItem = button

        if revealViewController() != nil
        {
            btn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
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
      else
        {
            return 0
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PopularListCell
    
        var size = CGSize(width: 292, height:195)
        setShadow(view: cell.view)
        if(collectionView == collectionview1)
        {
          let dic = hotdeals[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "Rs. \(dic.price)"
            var url = "http://13.58.57.113/storage/app/" + dic.primaryImage
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
            
        }
         else if(collectionView == collectionview2)
        {
            let dic = featuredpackgeary[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "Rs. \(dic.price)"
            var url = "http://13.58.57.113/storage/app/" + dic.primaryImage
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
        }
        else if(collectionView == collectionview3)
        {
            let dic = popularpackgesary[indexPath.row]
            cell.lblname.text = dic.mobileName
            cell.lblprice.text = "Rs. \(dic.price)"
            var url = "http://13.58.57.113/storage/app/" + dic.primaryImage
            cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
            
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
       
        return CGSize(width: 270, height: 195)
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

            Alamofire.request(webservices().baseurl + "home", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<HomeResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    print(resp)
                    if(resp.errorCode == 0)
                    {
                        webservices().StopSpinner()

                    self.hotdeals = resp.data.hotDeals
                        self.featuredpackgeary = resp.data.featuredPackages
                        self.popularpackgesary = resp.data.latestPackages
                        self.collectionview1.reloadData()
                        self.collectionview2.reloadData()
                        self.collectionview3.reloadData()



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
