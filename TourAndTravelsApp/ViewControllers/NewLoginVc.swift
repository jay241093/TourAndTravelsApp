//
//  NewLoginVc.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/10/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
class NewLoginVc: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate{
  
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var txtcountry: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtmobileno: SkyFloatingLabelTextField!
    var country_list = NSMutableArray()
    var pickerview = UIPickerView()
    
    
    
    @IBAction func nextaction(_ sender: Any) {
if(txtcountry.text == "")
{
    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Enter Country Code")
    self.present(alert, animated: true, completion: nil)
    
        }
     else if(txtmobileno.text == "")

{
    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Enter MObile Number")
    self.present(alert, animated: true, completion: nil)
    
        }
     else
        
{
    ApiSedOtp()
    
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        country_list = ["UK (+44)",
                        "USA (+1)",
                        "Algeria (+213)",
             "Andorra (+376)",
              "Angola (+244)",
              "Anguilla (+1264)",
            "Antigua & Barbuda (+1268)",
              "Argentina (+54)",
              "Armenia (+374)",
              "Aruba (+297)",
              "Australia (+61)",
              "Austria (+43)",
              "Azerbaijan (+994)",
              "Bahamas (+1242)",
              "Bahrain (+973)",
              "Bangladesh (+880)",
              "Barbados (+1246)",
              "Belarus (+375)",
              "Belgium (+32)",
              "Belize (+501)",
              "Benin (+229)",
              "Bermuda (+1441)",
              "Bhutan (+975)",
              "Bolivia (+591)",
              "Bosnia Herzegovina (+387)",
              "Brazil (+55)",
              "Brunei (+673)",
              "Bulgaria (+359)",
              "Burkina Faso (+226)",
              "Burundi (+257)",
              "Cambodia (+855)",
              "Cameroon (+237)",
              "Canada (+1)",
              "Cape Verde Islands (+238)",
             "Cayman Islands (+1345)",
              "Central African Republic (+236)",
              "Chile (+56)",
              "China (+86)",
              "Colombia (+57)",
             "Comoros (+269)",
              "Congo (+242)",
             " Cook Islands (+682)",
              "Costa Rica (+506)",
             " Croatia (+385)",
              "Cuba (+53)",
              "Cyprus North (+90392)",
              "Cyprus South (+357)",
              "Czech Republic (+42)",
              "Denmark (+45)",
              "Djibouti (+253)",
              "Dominica (+1809)",
              "Dominican Republic (+1809)",
              "Ecuador (+593)",
              "Egypt (+20)",
              "El Salvador (+503)",
              "Equatorial Guinea (+240)",
              "Eritrea (+291)",
              "Estonia (+372)",
              "Ethiopia (+251)",
              "Falkland Islands (+500)",
              "Faroe Islands (+298)",
              "Fiji (+679)",
              "Finland (+358)",
              "France (+33)" ,
              "French Guiana (+594)",
              "French Polynesia (+689)",
              "Gabon (+241)",
              "Gambia (+220)",
             " Georgia (+7880)",
              "Germany (+49)",
              "Ghana (+233)",
              "Gibraltar (+350)",
              "Greece (+30)",
              "Greenland (+299)",
             " Grenada (+1473)",
              "Guadeloupe (+590)",
              "Guam (+671)",
              "Guatemala (+502)",
             " Guinea (+224)",
              "Guinea - Bissau (+245)",
              "Guyana (+592)",
              "Haiti (+509)",
              "Honduras (+504)",
              "Hong Kong (+852)",
              "Hungary (+36)",
              "Iceland (+354)",
              "India (+91)",
              "Indonesia (+62)",
              "Iran (+98)",
              "Iraq (+964)",
              "Ireland (+353)",
              "Israel (+972)",
              "Italy (+39)",
             " Jamaica (+1876)",
              "Japan (+81)",
              "Jordan (+962)",
              "Kazakhstan (+7)",
              "Kenya (+254)",
              "Kiribati (+686)",
              "Korea North (+850)",
              "Korea South (+82)",
             " Kuwait (+965)",
              "Kyrgyzstan (+996)",
              "Laos (+856)",
              "Latvia (+371)",
              "Lebanon (+961)",
              "Lesotho (+266)",
              "Liberia (+231)",
              "Libya (+218)",
              "Liechtenstein (+417)",
              "Lithuania (+370)",
             " Luxembourg (+352)",
              "Macao (+853)",
              "Macedonia (+389)",
             " Madagascar (+261)",
             " Malawi (+265)",
              "Malaysia (+60)",
              "Maldives (+960)",
              "Mali (+223)",
              "Malta (+356)",
              "Marshall Islands (+692)",
              "Martinique (+596)",
              "Mauritania (+222)",
              "Mayotte (+269)",
            " Mexico (+52)",
             " Micronesia (+691)",
              "Moldova (+373)",
              "Monaco (+377)",
              "Mongolia (+976)",
              "Montserrat (+1664)",
              "Morocco (+212)",
              "Mozambique (+258)",
              "Myanmar (+95)",
             " Namibia (+264)",
              "Nauru (+674)",
             " Nepal (+977)",
              "Netherlands (+31)",
              "New Caledonia (+687)",
              "New Zealand (+64)",
              "Nicaragua (+505)",
              "Niger (+227)",
              "Nigeria (+234)",
             " Niue (+683)",
             "Norfolk Islands (+672)",
              "Northern Marianas (+670)",
              "Norway (+47)",
             " Oman (+968)",
              "Palau (+680)",
              "Panama (+507)",
              "Papua New Guinea (+675)",
              "Paraguay (+595)",
              "Peru (+51)",
              "Philippines (+63)",
              "Poland (+48)",
              "Portugal (+351)",
              "Puerto Rico (+1787)",
              "Qatar (+974)",
              "Reunion (+262)",
              "Romania (+40)",
              "Russia (+7)",
             "Rwanda (+250)",
              "San Marino (+378)",
              "Sao Tome & Principe (+239)",
              "Saudi Arabia (+966)",
              "Senegal (+221)",
              "Serbia (+381)",
              "Seychelles (+248)",
              "Sierra Leone (+232)",
              "Singapore (+65)",
              "Slovak Republic (+421)",
              "Slovenia (+386)",
              "Solomon Islands (+677)",
              "Somalia (+252)",
              "South Africa (+27)",
              "Spain (+34)",
              "Sri Lanka (+94)",
              "St. Helena (+290)",
             " St. Kitts (+1869)",
              "St. Lucia (+1758)",
              "Sudan (+249)",
              "Suriname (+597)",
              "Swaziland (+268)",
              "Sweden (+46)",
              "Switzerland (+41)",
             " Syria (+963)",
              "Taiwan (+886)",
              "Tajikstan (+7)",
              "Thailand (+66)",
              "Togo (+228)",
              "Tonga (+676)",
              "Trinidad & Tobago (+1868)",
              "Tunisia (+216)",
              "Turkey (+90)",
              "Turkmenistan (+7)",
              "Turkmenistan (+993)",
              "Turks & Caicos Islands (+1649)",
              "Tuvalu (+688)",
              "Uganda (+256)",
              "Ukraine (+380)",
              "United Arab Emirates (+971)",
             " Uruguay (+598)",
              "Uzbekistan (+7)",
              "Vanuatu (+678)",
              "Vatican City (+379)",
              "Venezuela (+58)",
              "Vietnam (+84)",
              "Virgin Islands - British (+1284)",
              "Virgin Islands - US (+1340)",
              "Wallis & Futuna (+681)",
              "Yemen (North)(+969)",
              "Yemen (South)(+967)",
              "Zambia (+260)",
              "Zimbabwe (+263)"]
        
    
      
        self.title = "Authenticate"
        setLeftView(textfield: txtcountry)
        setShadow(view: view1)
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        var doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(donePicker))
        
        var spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        pickerview.delegate = self
        pickerview.dataSource = self
        //yearpicker.inputView = pickerview
        txtcountry.inputView = pickerview
        txtcountry.inputAccessoryView = toolBar
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Pickerview delegate and datasource methods

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country_list.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        txtcountry.text = country_list.object(at: row) as! String
        return country_list.object(at: row) as! String
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == txtmobileno)
        {
        let maxLength = 10
            let currentString: NSString = textField.text as! NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        }
        else
        {
           return true
            
        }
        
    }
    
    
    
    
    
    func setLeftView(textfield: UITextField)
    {
        textfield.contentMode = .scaleAspectFit
        
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "Downarrow"))
        imageView.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        view.addSubview(imageView)
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    @objc func donePicker(sender:UIBarButtonItem)
    {
        txtcountry.resignFirstResponder()
        if(txtcountry.text == "")
        {
          txtcountry.text = country_list.object(at: 0) as! String
            
        }
        
    }

    
    func ApiSedOtp()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()

            print("+91\(txtmobileno.text!)")
            Alamofire.request(webservices().baseurl + "sendotp", method: .post, parameters:["mobile_number":"+91\(txtmobileno.text!)"] , encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    
                    webservices().StopSpinner()

                    if let data = response.result.value{
                        let dic: NSDictionary = response.result.value as! NSDictionary
                        
                        print(dic)
                        let errormsg = dic.value(forKey:"message") as! String
                        if(dic.value(forKey: "error_code") as! Int == 0)
                        {
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                            nextViewController.mobileno = self.txtmobileno.text!
                            nextViewController.otpstring = ((dic.value(forKey:"data") as! NSDictionary).value(forKey:"otp") as! NSNumber).stringValue
                            nextViewController.islogin = false

                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        
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
               "mobile_number":"+91\(txtmobileno.text!)"
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
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
                        nextViewController.mobileno = self.txtmobileno.text!
                        let num = resp.data.otp as! NSNumber
                        nextViewController.otpstring = num.stringValue
                        nextViewController.islogin = true
                        
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
