//
//  Log+CoreDataProperties.swift
//  Travelogue
//
//  Created by Miki Hodel on 12/7/20.
//
//

import Foundation
import CoreData


extension Log {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Log> {
        return NSFetchRequest<Log>(entityName: "Log")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawDate: Date?
    @NSManaged public var text: String?
    @NSManaged public var image: Data?
    @NSManaged public var trip: Trip?

}

extension Log : Identifiable {

}
