//
//  ProfileVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/3/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import SkyFloatingLabelTextField
class ProfileVC: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    @IBOutlet weak var txtlname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtfirstname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtmobilenumber: SkyFloatingLabelTextField!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnsave: UIButton!
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var viewimage: UIView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showActionSheet))
        
        imgUser.addGestureRecognizer(tapGesture)
        imgUser.isUserInteractionEnabled = true
        imgUser.layer.borderWidth=1.0
        imgUser.layer.masksToBounds = false
        imgUser.layer.borderColor = UIColor.white.cgColor
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2
        imgUser.clipsToBounds = true
        
        btnsave.layer.cornerRadius = 18.0
        if revealViewController() != nil
        {
            btn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        if(UserDefaults.standard.object(forKey:"Userid") != nil)
        {
            let name = UserDefaults.standard.value(forKey:"first") as! String
            let lname = UserDefaults.standard.value(forKey:"Last") as! String
            
            let email = UserDefaults.standard.value(forKey:"email") as! String
            let mobile = UserDefaults.standard.value(forKey:"mobile") as! String
            
            txtfirstname.text = name
            txtlname.text = lname
            txtemail.text = email
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        imgUser.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func camera()
    {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
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
