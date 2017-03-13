//
//  UploadViewController.swift
//  Instagram
//
//  Created by Tim Kim on 3/13/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var captionField: UITextView!
    @IBOutlet weak var uploadInstructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImageView.isUserInteractionEnabled = true
        captionField!.layer.borderWidth = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.captionField.text = ""
    }

    @IBAction func onUpload(_ sender: Any) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
        uploadInstructionLabel.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.uploadImageView.image = image
        } else{
            print("ERROR")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPost(_ sender: Any) {
        let photoPost = PFObject(className: "PhotoPost")
        photoPost["text"] = self.captionField.text!
        let imageData = self.uploadImageView.image?.lowestQualityJPEGNSData
        photoPost["image"] = imageData
        if let user = PFUser.current() {
            photoPost["user"] = user
        }
        photoPost.saveInBackground { (success: Bool, error: Error?) in
            if (success) {
                self.addPosttoUser(photoPost)
                //"segue" back to main feed
                self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    func addPosttoUser(_ post: PFObject) {
        let user = PFUser.current()
        if user?["postid"] != nil {
            var postList = user?["postid"] as! [String]
            postList.append(post.objectId!)
            user?["postid"] = postList
            user?.saveInBackground(block: { (success: Bool, error:Error?) in
                if (success) {
                    print("success save user")
                }
            })
        } else {
            var postList = [String]()
            postList.append(post.objectId!)
            user?["postid"] = postList
            user?.saveInBackground(block: { (success: Bool, error:Error?) in
                if (success) {
                    print("success save user")
                }
            })
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIImage
{
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)! as NSData }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! as NSData}
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)! as NSData }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! as NSData}
    var lowestQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.0)! as NSData }
}
