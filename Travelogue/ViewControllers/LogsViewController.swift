//
//  LogsViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/11/20.
//

import UIKit


class LogsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //mark the tableview
    @IBOutlet weak var logTableView: UITableView!
    var trip: Trip?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.logs?.count ?? 0
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)
        
        let log  = trip?.logs?[indexPath.row]
        print(log?.title)
        cell.textLabel?.text = log!.title
        
        //print(trip?.rawLogs)
        
        print(trip)
    
        /*
        let trip = trips[indexPath.row]
        cell.textLabel?.text = trip.tripTitle
    */
        
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.logTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.logTableView.reloadData()
    }

    //delete functions:
    func DeleteFunction(at indexPath: IndexPath) {
        guard let log = trip?.logs?[indexPath.row],
              let managedContext = log.managedObjectContext else {
            return
        }
        managedContext.delete(log)
            //must save the delete!
        do {
            try managedContext.save()
            logTableView.deleteRows(at: [indexPath], with: .automatic)
            logTableView.reloadData()
        } catch {
            print("Delete failed: \(error).")
            logTableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            DeleteFunction(at: indexPath)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LogDetailViewController, let segueIdentifier = segue.identifier
        else {
            return
        }
        destination.trip = trip
        if (segueIdentifier == "existingLog") {
            print("EXISTING LOG INFORMATION TRANSFER TO DETAIL VC")
            if let row333 = logTableView.indexPathForSelectedRow?.row {
                destination.log = trip?.logs?[row333]
            }
        }
    }

}
/*  example code
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if let destination = segue.destination as? DocumentViewController,
         let segueIdentifier = segue.identifier {
         destination.category = category
         if (segueIdentifier == "existingDocument") {
             if let row = documentsTableView.indexPathForSelectedRow?.row {
                 destination.document = documents[row]
             }
         }
     }
 }
 
 
 
 original
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     guard let destination = segue.destination as? LogDetailViewController
     else {
         return
     }
     destination.trip = trip
 }
 */
