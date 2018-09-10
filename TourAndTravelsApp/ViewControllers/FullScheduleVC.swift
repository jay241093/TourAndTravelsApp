//
//  FullScheduleVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/28/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
class FullScheduleVC: UIViewController {

    
//
//    @IBOutlet weak var pager: ScrollPager!
//
//    var headerary = ["Day 1 of 5","Day 2 of 5","Day 3 of 5","Day 4 of 5","Day 5 of 5"]
//    var tbl1 = UITableView()
//    var tbl2 = UITableView()
//    var tbl3 = UITableView()
//    var tbl4 = UITableView()
//    var tbl5 = UITableView()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       tbl1.delegate = self
//        tbl1.dataSource = self
//        tbl2.delegate = self
//        tbl2.dataSource = self
//        tbl3.delegate = self
//        tbl3.dataSource = self
//        pager.addSegmentsWithTitlesAndViews(segments: [
//            ("Day 1", tbl1),
//            ("Day 2", tbl2),
//            ("Day 3", tbl3)
//            ])
//        tbl1.register(UINib(nibName:"DepartureCell", bundle: nil), forCellReuseIdentifier: "cell")
//        tbl1.register(UINib(nibName:"HotelCheckinCell", bundle: nil), forCellReuseIdentifier: "cell1")
//
//        tbl3.register(UINib(nibName:"DepartureCell", bundle: nil), forCellReuseIdentifier: "cell")
//
//        tbl2.register(UINib(nibName:"DetailCellHistory", bundle: nil), forCellReuseIdentifier: "cell")
//
//        // Do any additional setup after loading the view.
//    }
//
//
//
//
//
//    // MARK: - tableview delegate and datasource methods
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//      if(tableView == tbl1)
//      {
//        return 2
//        }
//
//      else if(tableView == tbl2)
//        {
//            return 3
//        }
//        else
//      {
//        return 1
//
//        }
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if(tableView == tbl1)
//        {
//            if(indexPath.row == 0)
//            {
//            let cell : DepartureCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DepartureCell
//            cell.selectionStyle = .none
//            setShadow(view: cell.view)
//            return cell
//            }
//            else
//            {
//                let cell : HotelCheckinCell = tableView.dequeueReusableCell(withIdentifier:"cell1", for: indexPath) as! HotelCheckinCell
//                setShadow(view: cell.view)
//                cell.selectionStyle = .none
//
//                cell.lbldes.sizeToFit()
//
//                return cell
//
//            }
//        }
//        else if(tableView == tbl3)
//        {
//            let cell : DepartureCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DepartureCell
//            cell.selectionStyle = .none
//
//            return cell
//
//        }
//        else
//        {
//            let cell : DetailCellHistory = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DetailCellHistory
//            cell.lbldes.sizeToFit()
//            cell.selectionStyle = .none
//
//            setShadow(view: cell.view)
//            return cell
//
//        }
//
//    }
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return UITableViewAutomaticDimension
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
