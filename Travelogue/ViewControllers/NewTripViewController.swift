//
//  NewTripViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 12/7/20.
//

import UIKit

class NewTripViewController: UIViewController {

    @IBOutlet weak var newTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveNewTrip(_ sender: Any) {
        
        let trip = Trip(tripTitle: newTitleTextField.text ?? "Trip Title NA")
        
        do {
            try trip?.managedObjectContext?.save()
           
        } catch {
            print("Could not save the New trip :/ ")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
