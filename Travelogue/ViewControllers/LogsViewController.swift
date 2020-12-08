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
        return trip?.logs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath)
        
        if let log  = trip?.logs?[indexPath.row] {
            cell.textLabel?.text = log.title
        }
        
        
        //cell.textLabel?.text = "hahaha"
        
    
    
        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.logTableView.reloadData()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? LogDetailViewController
        else {
            return
        }
        destination.trip = trip
    }

}
