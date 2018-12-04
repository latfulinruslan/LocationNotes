//
//  Location+CoreDataProperties.swift
//  LocationNotes
//
//  Created by Ruslan on 16.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var note: Note?

}
