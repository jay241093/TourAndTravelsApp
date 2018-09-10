//
//  ExpandSearchVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/24/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class ExpandSearchVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    var titleary = ["Bedget Range","Duration","Theme","Suiatble for","General Tags"]
    var index = [0,1,2,3,4]
    
    @IBOutlet weak var tblview: UITableView!
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblview.layoutIfNeeded()

        tblview.reloadData()
        let camera = UIBarButtonItem(barButtonSystemItem:.done, target: self, action:#selector(btnOpenCamera))
        self.navigationItem.rightBarButtonItem = camera
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Tableview Delegate and Datasource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
       return titleary[section] as! String
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       let cell: ExpandSearchCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! ExpandSearchCell
       
       if(indexPath.section == 0)
       {
        cell.collectionview.tag = 0
        }
        else if(indexPath.section == 1)
        {
            cell.collectionview.tag = 1
        }
       else if(indexPath.section == 2)
       {
        cell.collectionview.tag = 2
        }
       else if(indexPath.section == 3)
       {
        cell.collectionview.tag = 3
        }
       else if(indexPath.section == 4)
       {
        cell.collectionview.tag = 4
        }
        tblheight.constant = tblview.contentSize.height
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return  UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.textColor = UIColor.white
        
        view.backgroundColor = UIColor(red:0.97, green:0.47, blue:0.36, alpha:1.0)

        self.view.addSubview(view)
          view.addSubview(label)
        switch  section {
        case 0:
            label.text = "  BUDGET RANGE"
        case 1:
            label.text = "  DURATION"
        case 2:
            label.text = "  THEME"
        case 3:
            label.text = "  SUITABLE FOR"
        case 4:
            label.text = "  GENERAL TAGS"

        default:
            label.text = "  TEST TEXT"

        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
   
    @objc func btnOpenCamera()
    {
        self.navigationController?.popViewController(animated: true)
        
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
