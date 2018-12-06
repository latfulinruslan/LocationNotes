//
//  NoteMapController.swift
//  LocationNotes
//
//  Created by Ruslan on 05.12.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit
import MapKit

class NoteAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    
    init(note: Note){
        if note.actualLocation != nil{
            coordinate = CLLocationCoordinate2D(latitude: note.actualLocation!.lat, longitude: note.actualLocation!.lon )
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }

    }
    
}

class NoteMapController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        if note?.actualLocation != nil{
            mapView.addAnnotation(NoteAnnotation(note: note!))
            mapView.centerCoordinate = CLLocationCoordinate2D(latitude: note!.actualLocation!.lat, longitude: note!.actualLocation!.lon)
        }
    }

}

extension NoteMapController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        return pin
    }
}
