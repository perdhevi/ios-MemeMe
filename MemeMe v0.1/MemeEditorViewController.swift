//
//  MemeEditorViewController.swift
//  MemeMe v0.1
//
//  Created by Raditya on 6/13/17.
//  Copyright © 2017 Raditya. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    


    @IBOutlet weak var imagePicked: UIImageView!
    
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    
    @IBOutlet weak var btnCamera: UIBarButtonItem!
    @IBOutlet weak var btnAction: UIBarButtonItem!
    @IBOutlet weak var btnCancel: UIBarButtonItem!
    
    @IBOutlet weak var tbBottom: UIToolbar!
    @IBOutlet weak var tbTop: UINavigationBar!
    
    var editingMeme : Meme!
    var editingIndex : Int = -1
    
    let memeAttributes : [String:Any] = [
        NSStrokeColorAttributeName : UIColor.black,
        
        NSForegroundColorAttributeName : UIColor.white,
        NSFontAttributeName : UIFont(name: "Impact", size: 40)!,
        NSStrokeWidthAttributeName: -2
        
    ]
    
    func enableNavButton(enable:Bool){
        btnAction.isEnabled = enable
    }
    
    func prepareTextfield(textField: UITextField){
        textField.defaultTextAttributes = memeAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTextfield(textField: bottomField)
        prepareTextfield(textField: topField)
        
        enableNavButton(enable: false)
        
    }

    func showPicker( sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        switch (sender as! UIBarButtonItem).tag {
        case 1:
            showPicker(sourceType: .photoLibrary)
            break
        case 2:
            showPicker(sourceType: .camera)
            break
        default:
            break
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicked.image = image
            enableNavButton(enable: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textDidBegin(_ sender: Any) {
        (sender as! UITextField).text = ""
    }

    func addMyObserver(selector aSelector : Selector,aName  name : NSNotification.Name){
        NotificationCenter.default.addObserver(self, selector: aSelector, name: name, object: nil)
    }
    func removeMyObserver(aName name:NSNotification.Name){
        NotificationCenter.default.removeObserver(self, name: name, object: nil)
    }
    
    //View will appear and disappear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        btnCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        addMyObserver( selector:  #selector(keyboardWillShow(_:)), aName: .UIKeyboardWillShow)
        addMyObserver( selector:  #selector(keyboardWillHide(_:)), aName: .UIKeyboardWillHide)
        
        if editingMeme != nil {
            topField.text = editingMeme.topText
            bottomField.text = editingMeme.bottomText
            imagePicked.image = editingMeme.originalImage
            enableNavButton(enable: true)
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeMyObserver(aName: .UIKeyboardWillShow)
        removeMyObserver(aName: .UIKeyboardWillHide)
    }
    
    
    func keyboardWillHide(_ notification:Notification){
        view.frame.origin.y = 0 
    }
    
    func keyboardWillShow(_ notification:Notification){
        
        if(bottomField.isFirstResponder) {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }else
            //added for iPhone SE
            if (topField.isFirstResponder) {
                view.frame.origin.y = -40
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func hideNavAndToolbar(hide: Bool){
        tbTop.isHidden = hide
        tbBottom.isHidden = hide
        
    }
    
    func generateMeme() -> UIImage {
        
        hideNavAndToolbar(hide: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        hideNavAndToolbar(hide: false)
        
        return memedImage
    }
    
    @IBAction func actionClicked(_ sender: Any) {
        let img = generateMeme()
        if editingMeme == nil {
            let img = generateMeme()
            let activity = UIActivityViewController(activityItems: [img], applicationActivities: nil)
            activity.completionWithItemsHandler = { (activityType:UIActivityType?, completed:Bool, returnedItems: [Any]? , error: Error? ) -> Void in
                if completed {
                    self.save()
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
        
            self.present(activity, animated: true, completion: nil)
        }else{
            editingMeme.meme = img
            editingMeme.topText = topField.text!
            editingMeme.bottomText = bottomField.text!
            replaceMeme(at: editingIndex, meme: editingMeme)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func save(){
        let meme = Meme(topText: topField.text!, bottomText: bottomField.text!, originalImage: imagePicked.image!, meme: generateMeme())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.meme.append(meme)
        
    }
    
    
    
    
}

