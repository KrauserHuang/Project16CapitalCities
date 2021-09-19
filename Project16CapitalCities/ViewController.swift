//
//  ViewController.swift
//  Project16CapitalCities
//
//  Created by Tai Chin Huang on 2021/9/17.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(chooseMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        // cause all those locations conform with MKAnnotation protocol, so mapView can use .addAnnotations and add those locations
        mapView.addAnnotations([london, oslo, paris, rome, washington])
    }
    
    @objc func chooseMapType() {
        let alertController = UIAlertController(title: "Map Settings", message: nil, preferredStyle: .alert)
        
        let standardAction = UIAlertAction(title: "Standard", style: .default) { action in
            self.mapType(.standard)
        }
        alertController.addAction(standardAction)
        
        let satelliteAction = UIAlertAction(title: "Satellite", style: .default) { action in
            self.mapType(.satellite)
        }
        alertController.addAction(satelliteAction)
        
        let hybridAction = UIAlertAction(title: "Hybrid", style: .default) { action in
            self.mapType(.hybrid)
        }
        alertController.addAction(hybridAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func mapType(_ mapType: MKMapType) {
        mapView.mapType = mapType
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 要先確認該annotation是屬於Capital屬性
        guard annotation is Capital else { return nil }

        let identifier = "Capital"
        // create can reuse annotationView(same as creating tableView/collectionView cell)
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        // if reuse annotationView don't exist, then create a new annotationView using MKPointAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            // .canShowCallout can call the title/subtitle of the annotation object, and also the custom view of .leftCalloutAccessoryView/.rightCalloutAccessoryView if set to true
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = .cyan

            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.pinTintColor = .cyan
            // says that if reuse one exist, then use it as annotationView
            annotationView?.annotation = annotation
        }
        return annotationView

//        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView else { return MKAnnotationView() }
//        annotationView.pinTintColor = .red
//        return annotationView
    }
    
    // called when tap accessoryView
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let alertController = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .default))
//
//        present(alertController, animated: true, completion: nil)
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.capital = capital
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

