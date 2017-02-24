//
//  LocationViewController.swift
//  Week 5 Assessment(G)
//
//  Created by george chin fu hou on 24/02/2017.
//  Copyright © 2017 George Chin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let lat = 40.705311
    let long = -74.258188
        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        let nextAnnotation = MKPointAnnotation()
        nextAnnotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        nextAnnotation.title = "Pin Point 1"
        nextAnnotation.subtitle = "New York"
        
        mapView.addAnnotation(nextAnnotation)
        
        mapView.delegate = self
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("Brooklyn") { (placemarksWeget, error)in
            if let placemarks = placemarksWeget {
                for placemark in placemarks {
                    let annotation = MKPointAnnotation()
                    //configure your annotation
                    if let coord = placemark.location?.coordinate{
                        annotation.coordinate = coord
                        annotation.title = placemark.name
                        annotation.subtitle = placemark.postalCode
                        
                        //add to map view
                        self.mapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
   
        
        
        
        
        // Do any additional setup after loading the view.
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    

func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //reusable identifier
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Home"
        if annotation.title! == "Pin Point 1"
        {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier){
                annotationView.annotation = annotation
                
                return annotationView
            }else{
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                annotationView.image = UIImage(named:"blue-dot")
                annotationView.canShowCallout = true
                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                return annotationView
            }
        }
        return nil
    }
    
    
    if annotation.title! == "Pin Point 1" {
        let customeView = MKAnnotationView()
        
        
        customeView.image = UIImage(named:"blue-dot")
        
        
        customeView.canShowCallout = true
        
        
        customeView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return customeView
    }
    else {
        return nil
    }
}
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
    
    guard let coordinate = view.annotation?.coordinate
        else {
            return
    }
    let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
}


