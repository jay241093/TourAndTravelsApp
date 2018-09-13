//
//  ReviewPopUp.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/12/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FloatRatingView
import  Alamofire

protocol ReviewAdd {
    func Addreview(package:PackageListing)
}


class ReviewPopUp: UIViewController ,UITextViewDelegate , FloatRatingViewDelegate{
  
    
    var rate : Float = 0.0
    var newpackage : PackageListing?

    var delegate: ReviewAdd?
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txttitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var ratingview: FloatRatingView!
    @IBOutlet weak var lblpackagename: UILabel!
    
    @IBOutlet weak var txtcomments: UITextView!
    
    @IBAction func submit(_ sender: Any) {
        
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txttitle.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter review title")
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else if(txtcomments.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter comments")
            self.present(alert, animated: true, completion: nil)
            
        }
         else
        {
            AddReview()
        }
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        removeAnimate()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtcomments.layer.cornerRadius = 10.0
        txtcomments.layer.borderWidth = 1.0
        txtcomments.layer.borderColor = UIColor.gray.cgColor
        txtcomments.delegate = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
      //  self.navigationController?.navigationBar.isHidden = true
       lblpackagename.text = newpackage?.mobileName
         showAnimate()
        
        if(UserDefaults.standard.object(forKey:"Userid") != nil)
        {
            let first = UserDefaults.standard.value(forKey:"first") as! String
            let last = UserDefaults.standard.value(forKey:"Last") as! String

        txtname.text = first + last
            
         }
        
        
        // Do any additional setup after loading the view.
    }

    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    
    
    // MARK: - User Define Functions
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                
               self.dismiss(animated:true, completion:nil)
                
            }
        });
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        txtcomments.text = ""
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        
        rate = ratingview.rating
    }
    
    
    func AddReview()
    {
        if webservices().isConnectedToNetwork() == true
        {
            print(ratingview.rating)
            webservices().StartSpinner()
            var parameters: Parameters =
                ["package_id":newpackage?.id,
                "rating":ratingview.rating,
                "name": txtname.text!,
                "review_title":txttitle.text!,
                    "review":txtcomments.text
                 ]
            
            Alamofire.request(webservices().baseurl + "package/add_reviews", method: .post, parameters:parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    webservices().StopSpinner()
                    
                    let dic: NSDictionary = response.result.value  as! NSDictionary
                    
                    if(dic.value(forKey:"error_code") as! Int == 0)
                    {
                        let alertController = UIAlertController(title:nil,  message:"Review Added Successfully", preferredStyle: .alert)
                        
                        // Create the actions
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            UIAlertAction in
                            
                            self.removeAnimate()
                            var num = self.newpackage?.id as! NSNumber
                            let review = PackageReview(id: (self.newpackage?.packageReviews.count)!+1, packageID:num.stringValue,rating:String(self.ratingview.rating), title: self.txtcomments.text!, text: self.txttitle.text!, name: self.txtname.text!, status: "1", createdAt: "2018-09-11 18:38:23", updatedAt: "2018-09-11 18:38:23")
                            self.newpackage?.packageReviews.append(review)
                            self.delegate?.Addreview(package: self.newpackage!)
                   
                        }
                      
                        // Add the actions
                        alertController.addAction(okAction)
                        
                
                        self.present(alertController, animated: true, completion: nil)
                        
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
