//
//  ViewController.swift
//  BarrieTransport
//
//  Created by Amal Baiju on 2019-07-23.
//  Copyright © 2019 Amal Baiju. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var driverData = DriverData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let barrieLatitude = 44.3894
        let barrieLongitude = -79.6903
        
        let barrieLocation = CLLocationCoordinate2D(latitude: barrieLatitude, longitude: barrieLongitude)
        
        let delta = 0.1
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        
        let regionToShow = MKCoordinateRegion(center: barrieLocation, span: span)
        
        mapView.setRegion(regionToShow, animated: true)
        
        for driver in driverData.driverPhoneNumber {
            print ("driver name is: \(driver.key)")
            
            let random1 = Int.random(in: -10...10)
            let random2 = Int.random(in: -10...10)
            
            let delta1 = 0.007 * Double(random1)
            let delta2 = 0.005 * Double(random2)
            
            let driverLocation = CLLocationCoordinate2D(latitude: barrieLatitude + delta1, longitude: barrieLongitude + delta2)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = driverLocation
            
            annotation.title = driver.key
            annotation.subtitle = driver.value
            
            mapView.addAnnotation(annotation)
            
            
        }
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        
    }


}

class CustomAnnotationView : MKMarkerAnnotationView{
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = true
        
        let uiButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40,height: 20))
        uiButton.setTitle("call", for: .normal)
        uiButton.setTitleColor(UIColor.blue, for: .normal)
        
        uiButton.addTarget(self, action: #selector(CustomAnnotationView.callThenumber),for: .touchUpInside)
        
        self.rightCalloutAccessoryView =   uiButton
    }
   @objc func callThenumber(sender: UIButton) {
    let driverName = annotation?.title
    let driverPhoneNumber = annotation?.subtitle
    
    print ("Calling \(driverName)!")
    
    let urlString = "tel://" + driverPhoneNumber!!
    if let url = URL(string: urlString) {
        UIApplication.shared.openURL(url)
    }else {
        
    }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

