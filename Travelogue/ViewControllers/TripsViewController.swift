//
//  TripsViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/11/20.
//

import UIKit
import CoreData

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //mark an outlet for the table view
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    //variables
    var trips : [Trip] = []
    
    //temp variable
    var animals = ["fish", "dog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        //getting data from coredata
         guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             print("Cant get appDelegate")
             return
         }
        //DID YOU IMPORT CORE DATA?
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest : NSFetchRequest<Trip> = Trip.fetchRequest()
        
        do {
        //do the fetch
        trips = try managedContext.fetch(fetchRequest)
            tripsTableView.reloadData()
           print("Table fetch reload from core data complete")
        } catch {
            //if the do fails
            print("FETCH FAILED")
        }
        
        
    }
    

    //table functions:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        let trip = trips[indexPath.row]
        
        //cell.textLabel?.text = animals[indexPath.row]
        cell.textLabel?.text = trip.tripTitle
        
        return cell
    }
    
    @IBAction func addTrip(_ sender: Any) {
      
        let alert = UIAlertController(title: "Add Category", message: "Enter new trip name.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: {
            (alertAction) -> Void in
            if let textField = alert.textFields?[0], let name = textField.text {
                let categoryName = name.trimmingCharacters(in: .whitespaces)
                if (categoryName == "") {
                    print("no name given for trip ")
                    return
                }
              //print the new trip name
            print(name)
            } else {
                print( "Category not created.\nThe name is not accessible.")
                return
            }
            
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "category name"
            textField.isSecureTextEntry = false
            
        })
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    //delete functions:
    func doDeleteFunction(at indexPath: IndexPath) {
        let trip = trips[indexPath.row]
        guard let managedContext = trip.managedObjectContext else {
            return
        }
        managedContext.delete(trip)
        do {
            try managedContext.save()
            trips.remove(at: indexPath.row)
            tripsTableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            print("Delete failed: \(error).")
            tripsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //doDeleteFunction(at: indexPath)
            
            let alert = UIAlertController(title: "Delete Category", message: " This trip contains saved logs. Do you want to delete it all?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {
                (alertAction) -> Void in
                // handle cancellation of deletion
                //self.categoriesTableView.reloadData()
                print("delete request cancelled")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: {
                (alertAction) -> Void in
                // handle deletion here
                //self.deleteCategory(at: indexPath)
                print("delete trip requested")
                self.doDeleteFunction(at: indexPath)
            }))
            self.present(alert, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    //segue:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LogsViewController,
            let row = tripsTableView.indexPathForSelectedRow?.row  else {
            return
        }
        destination.trip = trips[row]
    }
    
} //end of file
