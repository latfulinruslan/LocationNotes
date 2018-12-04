//
//  Note+CoreDataClass.swift
//  LocationNotes
//
//  Created by Ruslan on 16.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Note)
public class Note: NSManagedObject {
    class func newNote(name: String, inFolder: Folder?) -> Note{
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        note.name = name
        note.dateUpdate = NSDate();
        
        note.folder = inFolder
        
        return note
    }
    
    var actualImage: UIImage? {
        set{
            if newValue == nil{
                if self.image != nil{
                    CoreDataManager.sharedInstance.managedObjectContext.delete(self.image!)
                }
                self.imageSmall = nil
            } else{
                if self.image == nil{
                    self.image = ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
                }
                self.image?.imageBig = UIImageJPEGRepresentation(newValue!, 1) as NSData?
                self.imageSmall = UIImageJPEGRepresentation(newValue!, 0.05) as NSData?
            }
            dateUpdate = NSDate()
        }
        get {
            if self.image != nil{
                if image!.imageBig != nil{
                    return UIImage(data: self.image!.imageBig! as Data)
                }
            }
            return nil
        }
    }
    
    func addImage(image: UIImage){
        let imageNote = ImageNote(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        imageNote.imageBig = (UIImageJPEGRepresentation(image, 1)! as NSData)
        self.image = imageNote
    }
    
    
    func addLocation(latitude: Double, lontitude: Double){
        let location = Location(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        location.lat = latitude
        location.lon = lontitude
        
        self.location = location
    }
    
    var dateUpdateString: String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self.dateUpdate! as Date)
    }

}
