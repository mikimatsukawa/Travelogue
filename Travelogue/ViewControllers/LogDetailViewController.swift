//
//  LogDetailViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/11/20.
//

import UIKit

class LogDetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    var trip: Trip?
    var log: Log?
    
    @IBOutlet weak var logDate: UIDatePicker!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contextText: UITextView!
    
    let imagePickerController = UIImagePickerController()
    
    @IBAction func nameChanged(_ sender: Any) {
        title = nameTextField.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        
        print(log)
        
        if let log = log {
            
            nameTextField.text = log.title
            contextText.text = log.text
            logDate.date = log.date!
        
            //just need to set the image
        }
        
    }
    
    @IBAction func saveLog(_ sender: Any) {
        
        let name = nameTextField.text
        let text = contextText.text
        let date = logDate.date
        
        
        if log == nil  {
            //log not yet exists...
            if let trip = trip {
                log = Log(title: name, date: date, text: text)
            }
        } else {
            if let trip = trip {
                log?.setValue(contextText.text, forKey: "text")
                log?.setValue(nameTextField.text, forKey: "title")
                
                //log?.setValue( logDate.date , forKey: "date")
            }
        }
        
        if let log = log {
            //need to assing to the upper catatgory
            
            trip?.addToRawLogs(log)
        
            do {
                try log.managedObjectContext?.save()
            } catch {
                print("cant make log")
            }

        } else {
            print("save failed")
        }
    
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    /*
     example code:
     
     if document == nil {
         // document doesn't exist, create new one
         if let category = category {
             document = Document(name: documentName, content: content, category: category)
         }
     } else {
         // document exists, update existing one
         if let category = category {
             document?.update(name: documentName, content: content, category: category)
         }
     }
     
     if let document = document {
         do {
             let managedContext = document.managedObjectContext
             try managedContext?.save()
         } catch {
             alertNotifyUser(message: "Document not saved.\nAn error occured saving context.")
         }
     } else {
         alertNotifyUser(message: "Document not saved.\nA Document entity could not be created.")
     }
     
     
     
     */
    
    
    
    
    
    
    
// photo codes:
    
    @IBAction func cameraSelected(_ sender: UIBarButtonItem) {
        takePhotoWithCamera()
    }
    
    @IBAction func photoLibrarySelected(_ sender: Any) {
        selectPhotoFromLibrary()
    }
    
    func takePhotoWithCamera() {
        if (!UIImagePickerController.isSourceTypeAvailable(.camera)) {
            presentAlert(title: "No Camera", message: "This device has no camera.")
        } else {
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .camera
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func selectPhotoFromLibrary() {
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageView.image = pickedImage
            selectedImageView.contentMode = .scaleAspectFit
            
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    

}


/*
 
 original save
 
 @IBAction func saveLog(_ sender: Any) {
     
     let name = nameTextField.text
     let text = contextText.text
     let date = logDate.date
     
     if let log = Log(title: name, date: date, text: text) {
         //need to assing to the upper catatgory
         trip?.addToRawLogs(log)
     
         do {
             try log.managedObjectContext?.save()
         } catch {
             print("cant make log")
         }

         self.navigationController?.popViewController(animated: true)
     }
 
 }
 
 
 
 
 */
