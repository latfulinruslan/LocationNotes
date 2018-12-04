//
//  NoteController.swift
//  LocationNotes
//
//  Created by Ruslan on 20.11.2018.
//  Copyright © 2018 Ruslan. All rights reserved.
//

import UIKit

class NoteController: UITableViewController {
    
    var note: Note?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    
    @IBOutlet weak var folderLabel: UILabel!
    @IBOutlet weak var folderNameLabel: UILabel!
    
    

    @IBAction func pushDoneAction(_ sender: Any) {
        saveNote()
        navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        textName.text = note?.name
        textDescription.text = note?.textDescription
        imageView.image = note?.actualImage
        
        navigationItem.title = note?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        if let nameFolder = note?.folder{
            folderNameLabel.text = nameFolder.name
        } else {
            folderNameLabel.text = "-"
        }
        tableView.reloadData()
    }
    
    func saveNote() {
        if textName.text == "" && textDescription.text == "" && imageView.image == nil{
            CoreDataManager.sharedInstance.managedObjectContext.delete(note!)
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        if note?.name != textName.text || note?.description != textDescription.text {
            note?.dateUpdate = NSDate()
        }
        note?.name = textName.text
        note?.textDescription = textDescription.text
        note?.actualImage = imageView.image
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 && indexPath.section == 0 {
            let alertController = UIAlertController(title: "Image for note", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let firstActionCamera = UIAlertAction(title: "Make a photo", style: UIAlertActionStyle.default) { (alert) in                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(firstActionCamera)
            
            let secondActionPhoto = UIAlertAction(title: "Select from library", style: UIAlertActionStyle.default) { (alert) in
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(secondActionPhoto)
            
            if self.imageView.image != nil {
                let thirdActionDelete = UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive) { (alert) in
                self.imageView.image = nil
                }
                alertController.addAction(thirdActionDelete)
            }
            
            let fourthActionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (alert) in
                
            }
            alertController.addAction(fourthActionCancel)
            
            present(alertController, animated: true, completion: nil)
            
        }
    }
    // MARK:

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "goToSelectFolder" {
            (segue.destination as! SelectFolderController).note = note
        }
    }
}


extension NoteController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imageView.image = info[UIImagePickerControllerOriginalImage as! NSString] as? UIImage
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
}
