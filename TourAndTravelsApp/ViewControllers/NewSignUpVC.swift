//
//  NewSignUpVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/10/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
class NewSignUpVC: UIViewController {
    @IBOutlet weak var txtfname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtlname: SkyFloatingLabelTextField!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var txtmobileno: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBAction func SignUPaction(_ sender: Any) {
        if(txtfname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter firstname")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtlname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter lastname")
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if(txtemail.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter emailaddress")
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if (!isValidEmail(testStr:txtemail.text!))
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid email address")
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else
            
        {
            ApiCallResgister()
            
        }
    }
    
    
    
    func ApiCallResgister()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()

            let parameters: Parameters = [
                "fname":txtfname.text!,
                "lname": txtlname.text!,
                "mobile_number":txtmobileno.text!,
                "email": txtemail.text!
                
            ]
            
            Alamofire.request(webservices().baseurl + "register", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<RegisterResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    print(resp)
                    webservices().StopSpinner()

                    if(resp.errorCode == 0)
                    {
                        UserDefaults.standard.set(resp.data.fname, forKey: "first")
                        UserDefaults.standard.set(resp.data.lname, forKey: "Last")
                        UserDefaults.standard.set(resp.data.email, forKey: "email")
                        UserDefaults.standard.set(resp.data.mobileNumber, forKey: "mobile")
                        UserDefaults.standard.set(resp.data.token, forKey: "token")
                        
                        UserDefaults.standard.synchronize()
                        self.userdetails()
                        
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
    
    func userdetails()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()
            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/me", method: .post, parameters:[:] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    webservices().StopSpinner()

                    if let data = response.result.value{
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        let id = ((dic.value(forKey:"data") as! NSDictionary).value(forKey: "details") as! NSDictionary).value(forKey:"id") as! Int
                        
                        UserDefaults.standard.set(id, forKey: "Userid")
                      
                        self.BookNow(id: (globalpackage?.id)!)
                        
                    }
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
    func BookNow(id:Int)
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()

            let token = UserDefaults.standard.value(forKey: "token") as! String
            let headers = ["Accept": "application/json","Authorization": "Bearer "+token]
            //  print( UserDefaults.standard.value(forKey: "Token") as! String)
            
            
            Alamofire.request(webservices().baseurl + "customer/booking", method: .post, parameters:["user_id":UserDefaults.standard.value(forKey: "Userid") as! Int, "package_id":id] , encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    webservices().StopSpinner()

                    if let data = response.result.value{
                        
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                     
                            let alert = webservices.sharedInstance.AlertBuilder(title: "", message:"package booked suceessfully. our agency will shortly contacts you. thank you for booking this package")
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
    
    
    // MARK: - userdefine functins

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setShadow(view: view1)
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
