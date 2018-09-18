//  TableChildExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2017 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import XLPagerTabStrip
import SDWebImage

class TableChildExampleViewController: UITableViewController, IndicatorInfoProvider {

    let cellIdentifier = "postCell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
    init(style: UITableViewStyle, itemInfo: IndicatorInfo , str:String) {
        self.itemInfo = itemInfo
        super.init(style: style)
     self.itemInfo.title = str
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.object(forKey:"Index") != nil)
        {
            index = UserDefaults.standard.value(forKey:"Index") as! Int
        index = index + 1
            UserDefaults.standard.set(index, forKey:"Index")
            UserDefaults.standard.synchronize()
        }
        else
        {
            index = index + 1
            UserDefaults.standard.set(index, forKey:"Index")
            UserDefaults.standard.synchronize()
        }
        tableView.register(UINib(nibName: "HotelCheckinCell", bundle: Bundle.main), forCellReuseIdentifier:"cell1")
        tableView.register(UINib(nibName: "DetailCellHistory", bundle: Bundle.main), forCellReuseIdentifier:"cell")

        tableView.tag = index
       
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        if blackTheme {
            tableView.backgroundColor = UIColor(red: 15/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
        }
        
    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        var cell :DetailCellHistory = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DetailCellHistory

        if(index <= (globalpackage?.packageIty.count)!)
           {
            cell =  tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! DetailCellHistory

            setShadow(view: cell.view)
            cell.lblname.text = globalpackage?.packageIty[index-1].title
            cell.lbldes.text = "Description :" +  (globalpackage?.packageIty[index-1].text)!
//            var url = "http://tripgateways.co/storage/app/" +  (globalpackage?.packageItinerary[index-1].imagePath)!
//            cell.imageView?.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
            var Inclustion = globalpackage?.packageIty[index-1].inclusions as! String
            cell.lblinclusions.text =  "inclusions : \(Inclustion)"
          
            }

    
        return cell


    }
 
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

}
