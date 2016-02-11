//
//  NoteViewController.swift
//  parseSampleApplication
//
//  Created by Alexander Karpov on 05.02.16.
//  Copyright © 2016 Alex Karpov. All rights reserved.
//

import UIKit
import UITextView_Placeholder

enum ControllerState {
    case Viewing, Editing
}

class NoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!

    @IBOutlet weak var textTextView: UITextView!
    
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var note : Note? 
    
    var state : ControllerState! {
        didSet {
            if state == .Viewing {
                titleTextField.enabled = false
                textTextView.editable = false
                rightBarButtonItem.title = "Edit"
            } else {
                titleTextField.enabled = true
                textTextView.editable = true
                rightBarButtonItem.title = "Save"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textTextView.placeholder = "Note text here..."
        textTextView.placeholderColor = UIColor.lightGrayColor()
        
        if note != nil {
            state = .Viewing
        } else {
            state = .Editing
        }
        
        if state == .Viewing {
            rightBarButtonItem.title = "Edit"
        } else {
            rightBarButtonItem.title = "Save"
        }
        
        if let n = note {
            titleTextField.text = n.title
            textTextView.text = n.text
        }
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rightBarButtonItemPressed(sender: UIBarButtonItem) {
        if state == .Viewing {
            state = .Editing
        } else {
            saveObject()
            state = .Viewing
        }
    }
    
    func saveObject() {
        if let n = note {
            n.title = titleTextField.text
            n.text = textTextView.text
        } else {
            let n = Note(title: titleTextField.text, text: textTextView.text)
            note = n
        }
        note?.save(success: {
            print("object saved successfully!")
            }, error: {
                errorText in
                print(errorText)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
