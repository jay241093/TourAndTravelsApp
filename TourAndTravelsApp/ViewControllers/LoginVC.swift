


//
//  LoginVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/21/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Alamofire
import SkyFloatingLabelTextField

class LoginVC: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var VIEW: UIView!
    
    @IBOutlet weak var btnlogin: UIButton!
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtpassword: SkyFloatingLabelTextField!
    @IBAction func backaction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        
        if(txtemail.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title: "", message:"Please Enter Email Address")
            self.present(alert, animated: true, completion: nil)
            
            
        }
        else if(txtpassword.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title: "", message:"Please Enter Password")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
            
        {
            apilogincall()
            
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        loginButton.readPermissions = ["email","user_photos"]
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        btnlogin.layer.cornerRadius = 18.0
        navigationController?.navigationBar.isHidden = true
        setShadow(view: VIEW)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func FBlogin(_ sender: Any) {
        
        
    }
    //MARK:- facebook login delegate methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if ((error) != nil) {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            
            getFBUserData()
            // Navigate to other view
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    //MARK:- Get user data from facebook
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender, friendlists, friends"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    var  dict = result as! [String : AnyObject]
                    var name  = dict["name"]
                    var email  = dict["email"]
                    
                    if let imageURL = ((dict["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                        
                    }
                }
            })
        }
    }
    
    //MARK:- Gmail delegate methods
    
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        viewController.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            if user.profile.hasImage{
                // crash here !!!!!!!! cannot get imageUrl here, why?
                // let imageUrl = user.profile.imageURLWithDimension(120)
                let imageUrl = signIn.currentUser.profile.imageURL(withDimension: 120)
                print(" image url: ", imageUrl?.absoluteString)
                
                
            }
            GIDSignIn.sharedInstance().disconnect()
            
            // ...
        }
    }
    
    func apilogincall()
    {
        if webservices().isConnectedToNetwork() == true
        {
            
            let parameters: Parameters = [
                "email":txtemail.text!,
                "password": txtpassword.text!
            ]
            
            Alamofire.request(webservices().baseurl + "login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<LoginResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    print(resp)
                    if(resp.errorCode == 0)
                    {
                        
                        UserDefaults.standard.set(resp.data.fname, forKey: "first")
                        UserDefaults.standard.set(resp.data.lname, forKey: "Last")
                        UserDefaults.standard.set(resp.data.email, forKey: "email")
                        UserDefaults.standard.set(resp.data.mobileNumber, forKey: "mobile")
                        UserDefaults.standard.set(resp.data.token, forKey: "token")
                        UserDefaults.standard.set(1, forKey: "islogin")
                        
                        UserDefaults.standard.synchronize()
                        self.userdetails()
                        
                  
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
    
    
    
    func userdetails()
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
                        let id = ((dic.value(forKey:"data") as! NSDictionary).value(forKey: "details") as! NSDictionary).value(forKey:"id") as! Int
                        
                        UserDefaults.standard.set(id, forKey: "Userid")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        let alert = webservices.sharedInstance.AlertBuilder(title: "", message:"login successfully")
                        self.present(alert, animated: true, completion: nil)
                        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
