//
//  ViewController.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/9/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit
private let cellId = "Cell"
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Feed"
            
        case 1 :
            cell.textLabel?.text = "My Items"
            
        case 2 :
            cell.textLabel?.text = "Favorites"
            
        case 3 :
            cell.textLabel?.text = "Add Item"
            
            
        default:
            cell.textLabel?.text = ""
            
        }
        
        return cell
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        switch indexPath.row {
        case 0 :
            self.dismiss(animated: true, completion: nil)
        case 1 :
            self.performSegue(withIdentifier: "segueToMyItems", sender: nil)
            
        case 2 :
            self.performSegue(withIdentifier: "segueToFavorites", sender: nil)
            // case 3 :
            //  cell.textLabel?.text = "Add Item"
            
            
        default:
            self.performSegue(withIdentifier: "segueToMyItems", sender: nil)
            
        }
        
        
        
    }
}

