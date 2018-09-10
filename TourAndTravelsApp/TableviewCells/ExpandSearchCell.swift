
//
//  ExpandSearchCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/24/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class ExpandSearchCell: UITableViewCell ,UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
  
    var SelectedAry = NSMutableArray()
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var CollectionHeight: NSLayoutConstraint!
    var Budgetary = ["5000 - 100000","100000 - 15000","20000 - 25000"," 50000 and above"]
    var DurationAry = ["2nights -3days","3night - 4days","5night - 6days","6days and above"]
    var Themeary = ["Adventure","Bussiness" ,"HoneyMoon"]

    var Suitableforary = ["Family","Couple","Honeymoon","Older Pelople"]

    var generaltags = ["Family","Honeymoon","Tags","Birthdays","Beach", "Resort" , "Visting Places" , "Commercial"]
    var sizingCell = KTAwesomeCell()
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview.delegate = self
        collectionview.dataSource = self
        
        let layout: KTCenterFlowLayout = KTCenterFlowLayout()
       layout.minimumInteritemSpacing = 15.0
        layout.minimumLineSpacing  = 15.0
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    collectionview.collectionViewLayout = layout

        collectionview?.register(KTAwesomeCell.self, forCellWithReuseIdentifier: "cell")
        sizingCell = KTAwesomeCell()

        // Initialization code
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if(collectionView.tag == 0)
       {
       return Budgetary.count
        }
       else if(collectionView.tag == 1)
        {
            return DurationAry.count
        }
       else if(collectionView.tag == 2)
       {
        return Themeary.count
        }
       else if(collectionView.tag == 3)
       {
        return Suitableforary.count
        }
       else
       {
        return generaltags.count
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! KTAwesomeCell
        
        if(collectionView.tag == 0)
        {
        cell.label.text = Budgetary[indexPath.row]
        }
        
       else if(collectionView.tag == 1)
        {
            cell.label.text = DurationAry[indexPath.row]
        }
        else if(collectionView.tag == 2)
        {
            cell.label.text = Themeary[indexPath.row]
        }
        else if(collectionView.tag == 3)
        {
            cell.label.text = Suitableforary[indexPath.row]
        }
        else
        {
            cell.label.text = generaltags[indexPath.row]
        }
        
//cell.btntitle.setTitle(ary[indexPath.row], for: .normal)
//        cell.btntitle.layer.cornerRadius = 8.0
//         cell.btntitle.layer.shadowColor = UIColor.lightGray.cgColor
//         cell.btntitle.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//         cell.btntitle.layer.masksToBounds = false
//         cell.btntitle.layer.shadowRadius = 1.0
//         cell.btntitle.layer.shadowOpacity = 0.5
//        cell.btntitle.layer.borderWidth = 1.0
//        cell.btntitle.layer.borderColor =  UIColor.lightGray.cgColor
//        //cell.btnwidth.constant = 400
//        cell.btntitle.sizeToFit()
//
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(taplabel))
        //cell.label.addGestureRecognizer(tap)
        cell.label.tag = indexPath.row
         cell.label.isUserInteractionEnabled = true
        cell.tag = indexPath.row
        cell.addGestureRecognizer(tap)
        CollectionHeight.constant = collectionview.contentSize.height

        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView.tag == 0)
        {
        sizingCell.label.text = Budgetary[indexPath.row]
        }
        else if(collectionView.tag == 1)
        {
            sizingCell.label.text = DurationAry[indexPath.row]
        }
        else if(collectionView.tag == 2)
        {
            sizingCell.label.text = Themeary[indexPath.row]
        }
        else if(collectionView.tag == 3)
        {
            sizingCell.label.text = Suitableforary[indexPath.row]
        }
        else
        {
            sizingCell.label.text = generaltags[indexPath.row]
        }
        return sizingCell.intrinsicContentSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.bounds.size.width
        return CGSize(width: width, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.bounds.size.width
        return CGSize(width: width, height: 10)
    }
   
    
    @objc func taplabel(sender:UITapGestureRecognizer)
    {
    let tag = sender.view?.tag
        let index = NSIndexPath(row: tag!, section: 0)
        let cell =  collectionview.cellForItem(at: index as IndexPath) as! KTAwesomeCell
        
       if(cell.label.backgroundColor == UIColor.clear)
       {
        cell.backgroundColor = UIColor(red:0.27, green:0.51, blue:0.71, alpha:1.0)
        cell.label.textColor = UIColor.white
        cell.label.backgroundColor = UIColor(red:0.27, green:0.51, blue:0.71, alpha:1.0)
        SelectedAry.add(cell.label.text!)
        UserDefaults.standard.set(SelectedAry, forKey: "Selected")
        UserDefaults.standard.synchronize()
       }
       else
       {
        cell.backgroundColor = UIColor.clear
        cell.label.textColor = UIColor.gray
        cell.label.backgroundColor =  UIColor.clear
        SelectedAry.remove(cell.label.text!)
        UserDefaults.standard.set(SelectedAry, forKey: "Selected")
        UserDefaults.standard.synchronize()
        }
        
     
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
