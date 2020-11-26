//
//  LogDetailViewController.swift
//  Travelogue
//
//  Created by Miki Hodel on 11/11/20.
//

import UIKit

class LogDetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
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
        
    }
    
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
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    

}
