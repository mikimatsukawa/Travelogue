//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Miki Hodel on 12/7/20.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    
    var logs : [Log]? {
        return self.rawLogs?.array as? [Log]
    }
    
    convenience init?(tripTitle: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext
            else {
                return nil
        }
        self.init(entity: Trip.entity(), insertInto: managedContext)
        self.tripTitle = tripTitle
    
    

}
}

