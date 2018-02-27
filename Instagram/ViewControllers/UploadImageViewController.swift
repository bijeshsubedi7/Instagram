//
//  UploadImageViewController.swift
//  Instagram
//
//  Created by Bijesh Subedi on 2/25/18.
//  Copyright © 2018 Bijesh Subedi. All rights reserved.
//

import UIKit
import Parse

class UploadImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBAction func selectImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(image, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onUpload(_ sender: Any) {
        Post.postUserImage(image: uploadImageView.image, withCaption: captionField.text) { (success: Bool, error: Error?) in
            if (error != nil){
                print("Failure")
            } else {
                print("Success")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            uploadImageView.image = image
        } else {
            print ("Error")
        }
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
