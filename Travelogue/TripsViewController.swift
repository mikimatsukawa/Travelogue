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
    
}
