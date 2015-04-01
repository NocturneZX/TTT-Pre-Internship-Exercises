//
//  ViewController.swift
//  IOS8SwiftMapKitTutorial
//
//  Created by Arthur Knopper on 17/08/14.
//  Copyright (c) 2014 Arthur Knopper. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
                            
  override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    
    
        // Set a pin for a single specific location
        let location = CLLocationCoordinate2D(
          latitude: 40.741448,
          longitude: -73.989969
        )

        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "TurnToTech"
        annotation.subtitle = "New York"
        mapView.addAnnotation(annotation)
    
    
    
        // Set pins for 10 different restaurants near that point
        var restaurants:Dictionary<String,String> = [
                "ABC Kitchen":"35 E 18th St, Flatiron, New York, NY 10003",
                "Bite":"211 E 14th St, Gramercy, New York, NY 10003",
                "Cambodian Cuisine Torsu" : "Flatiron, New York, NY",
                "Gramercy Tavern" : "42 E 20th St, Flatiron, New York, NY 10003",
                "Great Burrito" : "100 W 23rd St, Chelsea, New York, NY 10011",
                "Johny's Luncheonette" : "124 W 25th St, Chelsea, New York, NY 10001",
                "Ootoya" : "8 W 18th St, Flatiron, New York, NY 10011",
                "Pippali" : "129 E 27th St, Flatiron, New York, NY 10016",
                "Taim" : "222 Waverly Pl, West Village, New York, NY 10014",
                "Woorijip Authentic Korean Food" : "12 W 32nd St, Midtown West, New York, NY 10001"
        ]

        for restaurant in restaurants {
            
            println("GEOCODE REQUEST INVOKED")
            var geocoder:CLGeocoder = CLGeocoder()
            var geoCompletionHandler:CLGeocodeCompletionHandler!
            geoCompletionHandler = {
                
                (objArray:[AnyObject]!, error:NSError!) -> Void in
                println("Callback invoked ...")
                var placeMark:CLPlacemark = objArray[0] as CLPlacemark
                let newAnnotation = MKPointAnnotation()
                newAnnotation.setCoordinate(placeMark.location.coordinate)
                newAnnotation.title = restaurant.0
                self.mapView.addAnnotation(newAnnotation)
            }
            geocoder.geocodeAddressString(restaurant.1, completionHandler:geoCompletionHandler)
        }

  }
    
// Uncomment to use a custom image instead of pins
    
//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//        var anView = self.mapView.dequeueReusableAnnotationViewWithIdentifier(annotation.title)
//        if anView == nil {
//            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotation.title)
//            
//            anView.image = UIImage(named:"restaurant.png")
//            anView.canShowCallout = true
//        }
//        else {
//            //we are re-using a view, update its annotation reference...
//            anView.annotation = annotation
//        }
//        
//        return anView
//    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

