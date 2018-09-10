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

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var lblmobile: UILabel!
    @IBOutlet weak var pinview: SVPinView!
    
    @IBOutlet weak var btnresend: UIButton!
    
    @IBOutlet weak var lbltime: UILabel!
    
    var timer : Timer?
    var count = 60
    var otpstring: String = ""
    var mobileno: String = ""

    @IBAction func resendaction(_ sender: Any) {
        ApiLogin()
        
    }
    
    @IBAction func VerifyAction(_ sender: Any) {
        
        if(pinview.getPin() == otpstring)
        {
           if(UserDefaults.standard.value(forKey:"islogin") != nil)
           {
            BookNow(id:(globalpackage?.id)!)
            
            }
            else
           {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewSignUpVC") as! NewSignUpVC
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
     
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        lbltime.text = "00:60"
        lblmobile.text = "Enter six digit code sent to  +91"
        
        setShadow(view:view1)
        
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
            Alamofire.request(webservices().baseurl + "sendotp", method: .post, parameters:["mobile_number":"919033324175"] , encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    
                    if let data = response.result.value{
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
                            self.count = 60
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
