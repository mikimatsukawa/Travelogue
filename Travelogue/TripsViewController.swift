//
//  TripsViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/11/20.
//

import UIKit

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    //mark an outlet for the table view
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    
    //temp variable
    var animals = ["fish", "dog"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    //table functions:
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        
        cell.textLabel?.text = animals[indexPath.row]
        //Give background Color
        cell.backgroundColor = UIColor.systemPink
    
    
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
    
    
    
    
    
}
