//
//  HotelListCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/5/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class HotelListCell: UITableViewCell , UICollectionViewDelegate , UICollectionViewDataSource{
    @IBOutlet weak var collectionview: UICollectionView!
 //   var hotel: DataClass1?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      //  GetHotels()
        collectionview.delegate = self
        collectionview.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
       return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! HotelGridCell
     //   cell.imgview?.sd_setImage(with: URL(string: (hotel?.the1017089108070373346.hotelDataNode.imgProcessed[0].l)!), placeholderImage: UIImage(named: "1"))

        cell.lblincluded.layer.cornerRadius = 10.0
        setShadow(view: cell.view)
        cell.view.layer.cornerRadius = 12.0
        return cell
        
    }
    
//    func GetHotels()
//    {
//        if webservices().isConnectedToNetwork() == true
//        {
//            Alamofire.request("http://developer.goibibo.com/api/voyager/?app_id=85c8c34f&app_key=9fef735ca2d91596900da1a1e8f1cbf2%09&method=hotels.get_hotels_data&id_list=%5B6085103403340214927%5D&id_type=_id", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<HotelList1>) in
//                switch response.result{
//
//                case .success(let resp):
//
//                    self.hotel = resp.data
//                    self.collectionview.reloadData()
//        case .failure(let err):
//                    print(err.localizedDescription)
//                }
//            }
//
//        }
//        else
//        {
//
//            webservices.sharedInstance.nointernetconnection()
//            NSLog("No Internet Connection")
//        }
//
//    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
