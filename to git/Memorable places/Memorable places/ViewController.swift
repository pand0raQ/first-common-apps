//
//  ViewController.swift
//  Memorable places
//
//  Created by Halik Magomedov on 10/17/16.
//  Copyright © 2016 Haliks. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    var manager = CLLocationManager()
    @IBOutlet var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
// longpress recognizer
        
        view.backgroundColor = UIColor.gray
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector (ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
            
        map.addGestureRecognizer(uilpgr)

        // if user pressed  detecting user gps when use button +
        if activePlace == -1 {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
            manager.requestAlwaysAuthorization()
            
        }else{
            // get place details to display on map    // Using to display that in map
            
            if places.count > activePlace{
                if let name = places[activePlace]["name"] {
                    if let lat = places[activePlace]["lat"]{
                        if let lon = places[activePlace]["lon"]{
                            if let latitude = Double(lat){
                                if let longitude = Double(lon) {
                                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                    let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                                    let region = MKCoordinateRegion(center: coordinate, span:  span)
                                    self.map.setRegion(region,animated: true)
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                }
                            }
                    }
                }
            }
        }
    }
        }
    // long press detection  in map
func longpress(gestureRecognizer : UIGestureRecognizer){
    if gestureRecognizer.state == UIGestureRecognizerState.began{
    
    let touchPoint = gestureRecognizer.location(in: self.map)
    let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
        // adding to title the name of that place
        var title = " "
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
        if error != nil{
            print(error)
        }else{
            
        if let placemark = placemarks?[0] {
        if placemark.subThoroughfare != nil {
             title += placemark.subThoroughfare! + " "
            }
            if placemark.thoroughfare != nil {
                title += placemark.thoroughfare!
            }
        
        }
        }
            if title == "" {
                title = "Added\(NSDate())"
                
                
            } // add anotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            annotation.title = title
            self.map.addAnnotation(annotation)
            places.append(["name":title, "lat":String(newCoordinate.latitude),"lon":String(newCoordinate.longitude)])
            UserDefaults.standard . set(places,forKey: "places")
        })

    
    }
    func  locationManager(_manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    let location = CLLocationCoordinate2D(latitude:locations[0].coordinate.latitude, longitude:locations[0].coordinate.longitude)
         let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.map.setRegion(region, animated: true)
        
        
    }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
}

