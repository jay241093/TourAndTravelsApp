//
//  ReviewListVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/12/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class ReviewListVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
  
    var newpackage :PackageListing?

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (newpackage?.packageReviews.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ReviewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  ReviewCell
        cell.selectionStyle = .none
        cell.ratingview.rating = Float((newpackage?.packageReviews[indexPath.row].rating)!)!
        cell.lblname.text = newpackage?.packageReviews[indexPath.row].name
        cell.lblcomment.text =  newpackage?.packageReviews[indexPath.row].text
         cell.lblcomment.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
