//
//  SearchVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/6/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
class SearchVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tblhight: NSLayoutConstraint!
    @IBOutlet weak var searchview: UIView!
    
    @IBOutlet weak var tblview: UITableView!
    var sectionary = ["Sort By","Duration", "Budget", "Price" ,"Themes"]
    
    var SortAry = ["Price Low to High","Price Low - High", "Latest"]
    var DurationAry = ["1-3 Days","4-7 Days", "8-14 Days", "2-3 Weeks" ,"3+ Weeks"]
    var BudgetAry = ["Economy","Standard", "Luxury"]
    var PricAary = ["< 100000","100001 - 25000", "250001 - 50000" , "> 50000"]
    var ThemesAry = [Theme]()


    override func viewDidLoad() {
        super.viewDidLoad()
         GettThemes()
        let shapeLayer = CAShapeLayer()
        
       // self.tblview.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

    }
    override func viewWillDisappear(_ animated: Bool) {
        
    //self.tblview.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
    
    func pathCurvedForView(givenView: UIView, curvedPercent:CGFloat) ->UIBezierPath
    {
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:givenView.bounds.size.width, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:givenView.bounds.size.height - (givenView.bounds.size.height*curvedPercent)), controlPoint: CGPoint(x:givenView.bounds.size.width/2, y:givenView.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()
        
        return arrowPath
    }
    // MARK: - tableview delegate and datasource methods
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        tblview.layer.removeAllAnimations()
//        tblhight.constant = tblview.contentSize.height
//        UIView.animate(withDuration: 0.5) {
//            self.tblview.updateConstraints()
//            self.tblview.layoutIfNeeded()
//        }
//
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionary[section]
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0)
        {
            
         return SortAry.count
        }
       else if(section == 1)
        {
            
            return DurationAry.count
        }
        else if(section == 2)
        {
            
            return BudgetAry.count
        }
        else if(section == 3)
        {
            
            return PricAary.count
        }
        else
        {
            
            return ThemesAry.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        tblhight.constant = tblview.contentSize.height

        if(indexPath.section == 0)
        {
            
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .circle
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor
            cell.checkbox.checkmarkStyle = .circle
            cell.lblname.text = sectionary[indexPath.row]
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            return cell
        }
        
       else if(indexPath.section == 1)
        {
            
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .square
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor

            cell.checkbox.checkmarkStyle = .tick
            cell.lblname.text = DurationAry[indexPath.row]
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)


            return cell
        }
        else if(indexPath.section == 2)
        {
            
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .square
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor

            cell.checkbox.checkmarkStyle = .tick
            cell.lblname.text = BudgetAry[indexPath.row]
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)


            return cell
        }
        else if(indexPath.section == 3)
        {
            
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .square
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor

            cell.checkbox.checkmarkStyle = .tick
 cell.lblname.text = PricAary[indexPath.row]
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            
            return cell
        }
        
        else
        {
            let dic = ThemesAry[indexPath.row]

            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .square
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor

            cell.checkbox.checkmarkStyle = .tick
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)

        cell.lblname.text = dic.name
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    

// MARK: - UserDefine functions

    func GettThemes()
    {
        if webservices().isConnectedToNetwork() == true
        {
            Alamofire.request(webservices().baseurl + "categories", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<ThemeList>) in
                switch response.result{
                    
                case .success(let resp):
                    if(resp.errorCode == 0)
                    {
                       
                        
                        if(resp.data.count == 0)
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title: "", message: "No Themes found")
                            self.present(alert, animated: true, completion: nil)
                        }
                        else
                        {
                            self.ThemesAry = resp.data
                            self.tblview.delegate = self
                            self.tblview.dataSource = self
                            
                            self.tblview.reloadData()
                            self.tblview.layoutIfNeeded()
                              self.tblview.updateConstraints()
                            
                        }
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
