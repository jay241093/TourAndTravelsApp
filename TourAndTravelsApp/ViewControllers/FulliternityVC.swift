//
//  FulliternityVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/4/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class FulliternityVC: ButtonBarPagerTabStripViewController {

    
    var package : PackageListing?
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBarView.selectedBar.backgroundColor = .white
        buttonBarView.backgroundColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)


     

        
        let newBackButton = UIBarButtonItem(title: "<Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(FulliternityVC.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        // Do any additional setup after loading the view.
    }

    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        var childViewControllers = [UIViewController]()
        print(package?.packageIty.count)
        for var i in 0...(globalpackage?.packageIty.count)! - 1
        {
            let new = i + 1 as NSNumber
            let child_1 = TableChildExampleViewController(style: .plain, itemInfo:"Day 1", str:"Day \(new.stringValue)")
             childViewControllers.append(child_1)
            
        }
        
        
        return childViewControllers
//        for index in childViewControllers.indices {
//            let nElements = childViewControllers.count - index
//            let n = (Int(arc4random()) % nElements) + index
//            if n != index {
//                childViewControllers.swapAt(index, n)
//            }
//        }
//        let nItems = 1 + (arc4random() % 8)
       /// return Array(childViewControllers.prefix(Int(nItems)))
    }
    
    override func reloadPagerTabStripView() {
        if arc4random() % 2 == 0 {
            pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        } else {
            pagerBehaviour = .common(skipIntermediateViewControllers: arc4random() % 2 == 0)
        }
        super.reloadPagerTabStripView()
    }
    @objc func back(sender: UIBarButtonItem) {
     
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.removeObject(forKey: "Index")
        UserDefaults.standard.synchronize()
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
