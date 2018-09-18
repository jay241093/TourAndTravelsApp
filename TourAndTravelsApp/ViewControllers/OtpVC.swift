//
//  OtpVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/10/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SVPinView
import Alamofire
class OtpVC: UIViewController {

    @IBOutlet weak var shadowview: UIView!
    @IBOutlet weak var lblmobile: UILabel!
    @IBOutlet weak var pinview: SVPinView!
    
    @IBOutlet weak var btnresend: UIButton!
    
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblotp: UILabel!
    var FromLogin : Int = 0

    var timer : Timer?
    var count = 60
    var otpstring: String = ""
    var mobileno: String = ""
    var islogin: Bool?
    @IBAction func resendaction(_ sender: Any) {
        ApiLogin()
        
    }
    
    @IBAction func VerifyAction(_ sender: Any) {
        
        if(pinview.getPin() == otpstring)
        {
            if(islogin)!
           {
            if(FromLogin == 1)
            {
                for controller in self.navigationController!.viewControllers as Array {
                    if controller.isKind(of: PopularPackgesVC.self) {
                        self.navigationController!.popToViewController(controller, animated: true)
                        break
                    }
                }
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Login Successfully")
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
            BookNow(id:(globalpackage?.id)!)
            }
            }
            else
           {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewSignUpVC") as! NewSignUpVC
            nextViewController.FromLogin = self.FromLogin
            self.navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        else
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Incorrect OTP")
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow(view:shadowview)

        lblotp.text = "please Enter Otp sent on  \(mobileno)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        lbltime.text = "00:60"
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func update() {
        if(count > 0){
            let minutes = String(count / 60)
            let seconds = String(count % 60)
            lbltime.text = minutes + ":" + seconds
            count -= 1;
            btnresend.isUserInteractionEnabled = false
            if count == 0 {
                timer?.invalidate()
                self.otpstring = ""
                lbltime.text = "00:00"
                btnresend.isUserInteractionEnabled = true
            }
        }else{
            timer?.invalidate()
        }
    }
    
    // MARK: - user define functions

  

    func ApiLogin()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()

            Alamofire.request(webservices().baseurl + "sendotp", method: .post, parameters:["mobile_number":"+91\(mobileno)"] , encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    webservices().StopSpinner()

                    if let data = response.result.value{
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        let errormsg = dic.value(forKey:"message") as! String

                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                            self.count = 60
                            self.apilogincall()
                        }
                        else if(errormsg.contains("The mobile number has already been taken."))
                        {
                            self.apilogincall()

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
    
    func apilogincall()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()

            let parameters: Parameters = [
                "mobile_number":"+91\(mobileno)"
            ]
            
            Alamofire.request(webservices().baseurl+"login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<LoginResponse>) in
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
                        UserDefaults.standard.set(resp.data.id, forKey: "Userid")
                        
                        
                        
                        UserDefaults.standard.synchronize()
                     let num = resp.data.otp as! NSNumber
                    self.otpstring = num.stringValue
                        
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
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: PopularPackgesVC.self) {
                                    self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                        
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
