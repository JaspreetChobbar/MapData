//
//  ViewController.swift
//  MapDemo
//
//  Created by MacStudent on 2020-01-13.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var locpoints = [LocationPoints]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        checkLocationServices()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchNewData()
    }
    
    func fetchNewData(){
        
        locpoints = appdelegate.fetchRecords()
        fetchLocsOnMap(locpoints)
    }
    
    @IBAction func current_location(_ sender: Any) {
        
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(viewRegion, animated: true)
            mapView.showsUserLocation = true
        }
        
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            break
        case .restricted:
            break
        case .authorizedAlways:
            mapView.showsUserLocation = true
            break
        }
    }
    
    func fetchLocsOnMap(_ locs: [LocationPoints]) {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        
        for loc in locs {
            let annotations = MKPointAnnotation()
            annotations.title = loc.title
            annotations.subtitle = String(loc.subTitle)
            annotations.coordinate = CLLocationCoordinate2D(latitude: loc.latitude, longitude: loc.longitude)
            mapView.addAnnotation(annotations)
        }
    }
    
    // delegate to show with priority
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "reuseIdentifier") as? MKMarkerAnnotationView
        if view == nil {
            view = MKMarkerAnnotationView(annotation: nil, reuseIdentifier: "reuseIdentifier")
        }
        view?.annotation = annotation
        view?.displayPriority = .required
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
        var index = 0
        
        for i in 0..<self.locpoints.count{
                        if(self.locpoints[i].subTitle ==  Int32(((view.annotation?.subtitle)!)!) ){
                            
                            index = i
                            }
                    }
            
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Edit") as! Edit
        
        secondViewController.index = index
        self.navigationController?.pushViewController(secondViewController, animated: true)
        
//        let alert = UIAlertController(title: "Delete", message: "delete the pin", preferredStyle: .alert)
//        
//        
//        let ok = UIAlertAction(title: "delete", style: .default, handler: { (action) -> Void  in
//    
//            for i in 0..<self.locpoints.count{
//                if(self.locpoints[i].subTitle ==  Int32(((view.annotation?.subtitle)!)!) ){
//                    self.appdelegate.deleteRecord(locpoints: self.locpoints[i])
//                    
//                    self.fetchNewData()
//                        break
//                    }
//            }
//            
//        })
//        let edit = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void  in
//            
//            for i in 0..<self.locpoints.count{
//                if(self.locpoints[i].subTitle ==  Int32(((view.annotation?.subtitle)!)!) ){
//                    
//                    self.edit(locdata: self.locpoints[i])
//                        break
//                    }
//            }
//            
//            
//            print("edit")
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
//            
//            print("cancel")
//        })
//        alert.addAction(ok)
//        alert.addAction(edit)
//        alert.addAction(cancel)
//      
//        self.present(alert, animated: true, completion: nil)
//        
//
//    }
//    
//    func edit(locdata: LocationPoints){
//        
//        let loc = locdata
//        
//        var titleTXT: UITextField?
//        var subTitleTXT: UITextField?
//        var latTXT: UITextField?
//        var lonTXT: UITextField?
//        
//        let alert = UIAlertController(title: "Update", message: "update the details", preferredStyle: .alert)
//        
//        
//        let ok = UIAlertAction(title: "update", style: .default, handler: { (action) -> Void  in
//            
//            let titl = titleTXT?.text
//            let subt = subTitleTXT?.text
//            let latt = latTXT?.text
//            let long = lonTXT?.text
//            
//            if (titl != nil && subt != nil && latt != nil && long != nil){
//                
//                self.appdelegate.updateRecord(locpoints : loc,title: titl!, subTitle: Int32(subt!)!, latitude: Double(latt!)!,longitude: Double(long!)!  )
//
//                self.fetchNewData()
//            }
//        })
//        
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
//            
//            print("cancel")
//        })
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        
//        alert.addTextField { (textField) in
//            titleTXT = textField
//            titleTXT?.placeholder = "add title"
//            titleTXT?.text = loc.title
//        }
//        alert.addTextField { (textField) in
//            subTitleTXT = textField
//            subTitleTXT?.placeholder = "add sub title"
//            subTitleTXT?.text = String(loc.subTitle)
//        }
//        alert.addTextField { (textField) in
//            latTXT = textField
//            latTXT?.placeholder = "add latitude"
//            latTXT?.text = String(loc.latitude)
//        }
//        alert.addTextField { (textField) in
//            lonTXT = textField
//            lonTXT?.placeholder = "add longitude"
//            lonTXT?.text = String(loc.longitude)
//        }
//        self.present(alert, animated: true, completion: nil)
//        
    }
    
}

