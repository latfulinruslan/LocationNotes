//
//  MapController.swift
//  LocationNotes
//
//  Created by Ruslan on 07.12.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMapView()
    }
    
    func loadMapView(){
        mapView.delegate = self
        
        for note in notes {
            if note.actualLocation != nil{
                mapView.addAnnotation(NoteAnnotation(note: note))
            }
        }
    }
}




extension MapController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        pin.animatesDrop = true
        pin.canShowCallout = true
        
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return pin
    }
}
