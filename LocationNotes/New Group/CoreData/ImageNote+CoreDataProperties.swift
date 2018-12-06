//
//  ImageNote+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Ruslan on 16.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageNote> {
        return NSFetchRequest<ImageNote>(entityName: "ImageNote")
    }

    @NSManaged public var imageBig: NSData?
    @NSManaged public var note: Note?

}
