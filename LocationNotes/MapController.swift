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
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        let ltgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.gestureRecognizers = [ltgr]
    }
    
    func handleLongTap(recognizer: UIGestureRecognizer) {
        if recognizer.state != .began {
            return
        }
        
        let point = recognizer.location(in: mapView)
        let convertLocation = mapView.convert(point, toCoordinateFrom: mapView)
        
        let newNote = Note.newNote(name: "", inFolder: nil)
        newNote.actualLocation = LocationCoordinate(lat: convertLocation.latitude, lon: convertLocation.longitude)
        
        let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
        noteController.note = newNote
        
        navigationController?.pushViewController(noteController, animated: true)
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        mapView.removeAnnotations(mapView.annotations)
        
        for note in notes {
            if note.actualLocation != nil{
                mapView.addAnnotation(NoteAnnotation(note: note))
            }
        }
    }
}


extension MapController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        
        if annotation is MKUserLocation{
            DispatchQueue.main.async {
                mapView.setCenter(annotation.coordinate, animated: true)
            }
            
            return nil
        }
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        pin.animatesDrop = true
        pin.canShowCallout = true
        
        pin.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        return pin
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl){
        let selectedNotePin = (view.annotation as! NoteAnnotation).note
        
        let noteController = storyboard?.instantiateViewController(withIdentifier: "noteSID") as! NoteController
        noteController.note = selectedNotePin
        
        navigationController?.pushViewController(noteController, animated: true)
    }
}
