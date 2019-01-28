//
//  NoteViewController.swift
//  Kick Ass Notes
//
//  Created by mobapp12 on 28/01/2019.
//  Copyright © 2019 mobapp12. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        NotesDao.sharedInstance.saveNote(title: tfTitle.text!, content: tvContent.text!)
        //terugkeren naar vorige scherm
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func keyboardKiller(_ sender: UITapGestureRecognizer) {
        tfTitle.resignFirstResponder()
        tvContent.resignFirstResponder()
    }
    
    
}
