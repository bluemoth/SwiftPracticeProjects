//
//  ViewController.swift
//  Project16_CapitalCities
//
//  Created by Jacob Case on 3/1/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Challenge 2 - Provide a button to allow user to select between standard/sallite map type*/
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(selectMapType))
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
    }
    
    /* Challenge 2 - Provide a button to allow user to select between standard/sallite map type*/
    @objc func selectMapType() {
        let ac = UIAlertController(title: "Select View Style", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Satellite View", style: .default, handler: changeMapType))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: changeMapType))
        present(ac, animated: true)
    }
    
    /* Challenge 2 - Provide a button to allow user to select between standard/sallite map type*/
    func changeMapType(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        
        switch actionTitle {
        case "Satellite View":
            mapView.mapType = .satellite
        case "Standard view":
            mapView.mapType = .standard
        default:
            mapView.mapType = .standard
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1
        guard annotation is Capital else { return nil }

        // 2
        let identifier = "Capital"

        // 3
        /* Challenge 1 - Downcast dequeue as MkPinAnnotationView to allow pinTint color to be changed*/
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            //4
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true

            // 5
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6
            annotationView?.annotation = annotation
        }

        annotationView?.pinTintColor = .green
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let placeName = capital.title
        let placeInfo = capital.info

        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }


}

