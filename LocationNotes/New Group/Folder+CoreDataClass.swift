//
//  Folder+CoreDataClass.swift
//  LocationNotes
//
//  Created by Ruslan on 16.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {

    class func newFolder(name: String) -> Folder {
        let folder = Folder(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        folder.name = name
        folder.dateUpdate = NSDate();
        
        return folder
    }
    
    func addNote() -> Note{
        let note = Note(context: CoreDataManager.sharedInstance.managedObjectContext)
        
        note.folder = self
        note.dateUpdate = NSDate();
        
        return note
    }
    
    var sortedNotes: [Note]{
        let sortDescriptor = NSSortDescriptor(key: "dateUpdate", ascending: false)
        return self.notes?.sortedArray(using: [sortDescriptor]) as! [Note]
    }
}
