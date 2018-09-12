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
    
    var Finalsortary = NSMutableArray()
    var FinalDurationAry = NSMutableArray()
    var FinalBudgetAry = NSMutableArray()
    var FinalPricAary = NSMutableArray()
    var FinalThemeAry = NSMutableArray()

    
    
    var sectionary = ["Sort By","Duration", "Budget", "Price" ,"Themes","Type"]
    
    var SortAry = ["Price Low to High","Price Low - High", "Latest"]
    var sortid = ["0","1","2"]
    var DurationAry = ["1-3 Days","4-7 Days", "8-14 Days", "2-3 Weeks" ,"3+ Weeks"]
    var Durationid = ["1,3","4,7","8,14","14,21","21"]

    var BudgetAry = ["economy","standard", "luxury"]
    var PricAary = ["< 10000","10001 - 25000", "25001 - 50000" , "> 50000"]
    var Priceid = ["10000","10001,25000","25001,50000","50000"]
    var ThemesAry = [Theme]()
    
    var International = ["Domestic" , "International"]

    @IBAction func ApplyAction(_ sender: Any) {
        
      
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackagesListVC") as! PackagesListVC
        nextViewController.sortary = Finalsortary
        nextViewController.DurationAry = FinalDurationAry
        nextViewController.BudgetAry = FinalBudgetAry
        nextViewController.PricAary = FinalPricAary
        nextViewController.ThemeAry = FinalThemeAry
     self.navigationController?.pushViewController(nextViewController, animated: true)
        

    }
    
    @IBAction func clearaction(_ sender: Any) {
        tblview.reloadData()
        Finalsortary.removeAllObjects()
        FinalBudgetAry.removeAllObjects()

        FinalPricAary.removeAllObjects()

        FinalDurationAry.removeAllObjects()
        FinalThemeAry.removeAllObjects()
        for var j in 0...5{
        for var i in 0..<tblview.numberOfRows(inSection: j) {
           
                var cell: CheckBoxCell? = tblview.cellForRow(at: IndexPath(row: i, section:j)) as! CheckBoxCell
                cell?.checkbox.isChecked = false
            
        }
        }
    }
    
    
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
        
        return sectionary.count
        
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
        else if(section == 4)
        {
            
            return ThemesAry.count
        }
        else
        {
            return International.count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      tblhight.constant = tableView.contentSize.height

        if(indexPath.section == 0)
        {
            
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .circle
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor
            cell.checkbox.checkmarkStyle = .circle
            cell.lblname.text = SortAry[indexPath.row]
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
        
        if(indexPath.section == 4)
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
        else
        
        {
            let cell :CheckBoxCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as!  CheckBoxCell
            cell.checkbox.borderStyle = .square
            cell.checkbox.layer.borderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0).cgColor
            
            cell.checkbox.checkmarkStyle = .tick
            cell.checkbox.checkedBorderColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.checkbox.checkmarkColor = UIColor(red:1.00, green:0.15, blue:0.00, alpha:1.0)
            cell.lblname.text = International[indexPath.row]

       
            return cell

        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as!  CheckBoxCell
        if(cell.checkbox.isChecked)
        {
            cell.checkbox.isChecked = false
        }
        else
        {
              cell.checkbox.isChecked = true
            
        }

       if(indexPath.section == 0)
       {
        Finalsortary.removeAllObjects()
        Finalsortary.add(sortid[indexPath.row])
        for i in 0..<tableView.numberOfRows(inSection: indexPath.section) {
            if i != indexPath.row {
                var cell: CheckBoxCell? = tableView.cellForRow(at: IndexPath(row: i, section: indexPath.section)) as! CheckBoxCell
                cell?.checkbox.isChecked = false
                
                //Do your stuff
            }
        }

        
        
        }
       else if(indexPath.section == 1)
        {
            var cell = tableView.cellForRow(at:indexPath) as? CheckBoxCell

            if(cell?.checkbox.isChecked)!
            {
            FinalDurationAry.add(Durationid[indexPath.row])
            }
            else
            {
                FinalDurationAry.remove(sortid[indexPath.row])
            }
        }
       else if(indexPath.section == 2)
       {
        var cell = tableView.cellForRow(at:indexPath) as? CheckBoxCell
        
        if(cell?.checkbox.isChecked)!
        {
        FinalBudgetAry.add(BudgetAry[indexPath.row])
        }
        else
        {
            FinalBudgetAry.remove(BudgetAry[indexPath.row])

        }
        }
       else if(indexPath.section == 3)
        
       {
        var cell = tableView.cellForRow(at:indexPath) as? CheckBoxCell

        
        if(cell?.checkbox.isChecked)!
        {
        FinalPricAary.add(Priceid[indexPath.row])
            
        }
        else
        {
            FinalPricAary.remove(Priceid[indexPath.row])

        }
        }
       else if(indexPath.section == 4)
       {
        var cell = tableView.cellForRow(at:indexPath) as? CheckBoxCell
        
        
        if(cell?.checkbox.isChecked)!
        {
        FinalThemeAry.add(ThemesAry[indexPath.row].id)
        }
        else
        {
            FinalThemeAry.remove(ThemesAry[indexPath.row].id)

        }
        }
        
        
    }
    
  
// MARK: - UserDefine functions

    func GettThemes()
    {
        if webservices().isConnectedToNetwork() == true
        {
            webservices().StartSpinner()
            Alamofire.request(webservices().baseurl + "categories", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<ThemeList>) in
                switch response.result{
                    
                case .success(let resp):
                     webservices().StopSpinner()
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
