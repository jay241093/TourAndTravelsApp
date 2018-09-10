//
//  SearchDestinationVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/22/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import MapKit
class SearchDestinationVC: UIViewController , CLLocationManagerDelegate , UITextFieldDelegate, selectedcity{
   
    
    
    @IBOutlet weak var txtdestination: UITextField!
    @IBOutlet weak var txtarrival: UITextField!
    @IBOutlet weak var txtdeparture: UITextField!
    @IBOutlet weak var txtbudget: UITextField!
    @IBOutlet weak var btnsearch: UIButton!
    @IBOutlet weak var btn: UIButton!
    var locationManager = CLLocationManager()
    var tableview = UITableView()
  
    
    // #Mark : IBAction methods
    
    
    @IBAction func SearchAction(_ sender: Any) {
    
      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackagesListVC") as! PackagesListVC
      nextViewController.cityname = txtdestination.text
      self.navigationController?.pushViewController(nextViewController, animated: true)
       
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
       
        
        txtdestination.clearButtonMode = .whileEditing
        txtdestination.delegate = self
        navigationController?.navigationBar.barTintColor = UIColor.white
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "backdround")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        rounded(textfield: txtdestination)
        rounded(textfield: txtarrival)
        rounded(textfield: txtdeparture)
        rounded(textfield: txtbudget)
        btnsearch.layer.cornerRadius = 18.0
        tableview.frame = CGRect(x:txtdestination.frame.minX, y:txtdestination.frame.maxY + 5, width: txtdestination.frame.width, height: 180)
        self.view.addSubview(tableview)
      
        tableview.isHidden = true
       
        tableview.reloadData()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
         txtdestination.resignFirstResponder()
    }
    

    // MARK: - locationManager delegate methods
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            showLocationDisabledpopUp()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error" , Error.self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations.last
      
    }
    // MARK: - Textfield delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        var search : String = ""
//        self.view.bringSubview(toFront: tableview)
//        self.tableview.isHidden = false
//
//        if string.isEmpty
//        {
//            search = String(search.characters.dropLast())
//        }
//        else
//        {
//            search = txtdestination.text!+string
//        }
//        if(textField == txtdestination)
//       {
//
//        if(search != "")
//        {
//            placeAutocomplete(text:search)
//            self.tableview.isHidden = false
//
//        }
//        else
//        {
//            self.resultArray.removeAll()
//            self.tableview.isHidden = true
//        }
//        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchCityVC") as! SearchCityVC
        self.present(nextViewController, animated: true, completion: nil)
        self.navigationController?.modalPresentationStyle = UIModalPresentationStyle.currentContext

        nextViewController.delegate = self
        txtdestination.resignFirstResponder()

    }
  
    // MARK: - User Define Function
    
    func rounded(textfield:UITextField)
    {
        textfield.backgroundColor = UIColor.white
       textfield.layer.cornerRadius = 18
        textfield.layer.borderColor = UIColor.clear.cgColor
    }
    
    func setLocation()
    {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
  
    func showLocationDisabledpopUp() {
        let alertController = UIAlertController(title: "Location Access  Disabled", message: "We need your location", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Setting", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func Select(str: String) {
        txtdestination.text = str
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
