
//
//  ImageListVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/23/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SDWebImage
class ImageListVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var lblcount: UILabel!
    @IBOutlet weak var lblname: UILabel!
    var packageList : PackageListing?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
// MARK: - CollectioView Delegate and DataSourceMethods

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (packageList?.packageImages.count)!
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ImageListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ImageListCell
        var url = "http://13.58.57.113/storage/app/" + (packageList?.packageImages[indexPath.row].path)!

        cell.imgview.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "1"))
        
        let num = packageList?.packageImages[indexPath.row].id as! NSNumber
        cell.lblname.text = String(num.stringValue)
        cell.layer.masksToBounds = false
        let total = packageList?.packageImages.count as! NSNumber
        cell.lblcount.text = String(num.stringValue) + "/" + String(total.stringValue)
       // cell.lblname.text =  packageList?.packageImages[indexPath.row].description
        cell.imgview?.contentMode = .scaleAspectFill
        cell.imgview?.clipsToBounds = true
        return cell
        
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
