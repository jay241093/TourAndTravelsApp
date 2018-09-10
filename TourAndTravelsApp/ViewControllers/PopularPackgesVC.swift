//
//  PopularPackgesVC.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/3/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import GooglePlaces
class PopularPackgesVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
  
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var view4: UIView!
    
    @IBOutlet weak var view5: UIView!
    
    @IBOutlet weak var collectionview1: UICollectionView!
    
    @IBOutlet weak var collectionview2: UICollectionView!
    
    @IBOutlet weak var collectionview3: UICollectionView!
    
    @IBOutlet weak var collectionview4: UICollectionView!
    
    @IBOutlet weak var collecitonview5: UICollectionView!
    
    @IBOutlet weak var btn: UIButton!
    
    
    @IBAction func ActionSearch(_ sender: Any) {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        autocompleteController.autocompleteFilter?.type = .city
        let navigationController = UINavigationController(rootViewController: autocompleteController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "PopularListCell", bundle:nil)
        
        collectionview1.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview2.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview3.register(nibName, forCellWithReuseIdentifier: "cell")
        collectionview4.register(nibName, forCellWithReuseIdentifier: "cell")
        collecitonview5.register(nibName, forCellWithReuseIdentifier: "cell")

        setShadow(view: view1)
        setShadow(view: view2)
        setShadow(view: view3)

        setShadow(view: view4)

        setShadow(view: view5)
        let button = UIBarButtonItem(barButtonSystemItem:.search, target: self, action: #selector(PopularPackgesVC.ActionSearch))
     
        navigationController?.navigationItem.rightBarButtonItem = button

        if revealViewController() != nil
        {
            btn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }
// MARK: - Collection view delegate and datasource methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularListCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! PopularListCell
    
        var size = CGSize(width: 292, height:195)
        setShadow(view: cell.view)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        return CGSize(width: 292, height: 195)
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
extension PopularPackgesVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
       CityName = ""
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PackagesListVC") as! PackagesListVC
        nextViewController.cityname = place.name
        self.navigationController?.pushViewController(nextViewController, animated: true)

        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
       
    }
    
}
