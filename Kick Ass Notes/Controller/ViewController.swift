//
//  ViewController.swift
//  Kick Ass Notes
//
//  Created by mobapp12 on 28/01/2019.
//  Copyright © 2019 mobapp12. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items:[Note] = [Note]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        items = NotesDao.sharedInstance.getAllNotes()
        tableView.reloadData()
    }
}
//uitbreiding op viewcontroller, methoden datasource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let noteForRow = items[indexPath.row]
        cell.textLabel!.text = noteForRow.title
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    
    
}

extension ViewController : UISearchBarDelegate{
    
}
