//
//  Log+CoreDataClass.swift
//  Travelogue
//
//  Created by Miki Hodel on 12/7/20.
//
//

import UIKit
import CoreData

@objc(Log)
public class Log: NSManagedObject {
    
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate? as Date?
        }
    }
    
    
    /*
    var logImage: UIImage? {
        get {
            if let imageData = image as Data? {
                return UIImage(data: imageData)
            } else {
                return nil
            }
        }
        set {
            if let logImage = newValue {
                image = convertImageToNSData(image: logImage)
            }
        }
    }
 */
    
    
    
    convenience init?(title: String?, date: Date?, text: String?) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate  //UIKit is needed to access UIApplication
        guard let managedContext = appDelegate?.persistentContainer.viewContext
            else {
                return nil
        }
        self.init(entity: Log.entity(), insertInto: managedContext)
        
        self.title = title
        self.date = date
        self.text = text
        
        
    }
    
   

    

}
