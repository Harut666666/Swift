//
//  AddressLocationViewController.swift
//  UsersProject
//
//  Created by Harut on 3/6/20.
//  Copyright © 2020 Harut Yeremyan. All rights reserved.
//

import Foundation
import MapKit

class AddressLocationViewController: UIViewController {
    
    var address = ""
    
   
    @IBOutlet weak var addressMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAddressLocation(address: address)
        // Do any additional setup after loading the view.
    }
    func showAddressLocation(address:String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start{
            response,error in
            guard let response = response else {
                print("error?.localizedDescription")
                return
            }
            let latitude = response.boundingRegion.center.latitude
            let longtitude = response.boundingRegion.center.longitude
            
            let annotation = MKPointAnnotation()
            annotation.title = self.address
            annotation.coordinate = CLLocationCoordinate2DMake(latitude, longtitude)
            self.addressMapView.addAnnotation(annotation)
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longtitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            self.addressMapView.setRegion(region, animated: true)
        }
    }

}
