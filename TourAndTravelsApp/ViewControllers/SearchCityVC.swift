//
//  SearchCityVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/29/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import Alamofire
protocol selectedcity {
    
    func Select(str: String)
}

class SearchCityVC: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblview: UITableView!
    var CityAry = [City]()
    
    var filterCity = [City]()
    
    var delegate: selectedcity?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        ApiCity()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
  // MARK: - tabelview delegate methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CityAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:SearchCityCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! SearchCityCell
       
        let dic = CityAry[indexPath.row]
       cell.lblname.text = dic.cityName
        cell.lblstatename.text = dic.stateName

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dic = CityAry[indexPath.row]
        self.dismiss(animated: true, completion: nil)
        delegate?.Select(str: dic.cityName)
      }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        CityAry.removeAll()
        if(searchText == "")
        {
            CityAry = filterCity
            tblview.reloadData()

        }
        else
        {
        for dic in filterCity
        {
           if(dic.cityName.lowercased().contains(searchText.lowercased()) || dic.stateName.lowercased().contains(searchText.lowercased()))
           {
            CityAry.append(dic)
            
            }
            
        }
        tblview.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func ApiCity()
    {
        if webservices().isConnectedToNetwork() == true
        {
             Alamofire.request(webservices().baseurl + "cities", method: .post, parameters:[:], encoding: JSONEncoding.default, headers: nil).responseJSONDecodable{(response:DataResponse<CityResponse>) in
                switch response.result{
                    
                case .success(let resp):
                    if(resp.errorCode == 0)
                    {
                     self.CityAry = resp.data
                    self.filterCity = resp.data
                        
                        self.tblview.reloadData()
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
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
