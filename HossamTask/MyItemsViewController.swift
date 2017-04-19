//
//  MyItemsViewController.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/10/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit

class MyItemsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var itemsArray : Array<Item> = []
    
    @IBOutlet var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "HistoryCell", bundle:nil)
        self.myTableView.register(nibName, forCellReuseIdentifier: "HistoryCell")
        self.itemsArray = ItemUtilityClass.sharedInstance.getAllUserItems()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return self.itemsArray.count ;
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        
        let item = self.itemsArray[indexPath.row]
        cell.imgOwner.image = UIImage(data:item.ownerImage as! Data,scale:1.0)
        cell.lblOwnerName.text = item.ownerName
        cell.imgItem.image = UIImage(data:item.image as! Data,scale:1.0)
        cell.lblDetails.text = item.details
        
        cell.lblDate.text = ItemUtilityClass.sharedInstance.timeAgoSinceDate(item.timeStamp as! Date,numericDates: true)
       
        
        cell.btnFavorite.addTarget(self,  action: #selector(pressedDelete(button:)), for: .touchUpInside)
        cell.btnFavorite.setTitle("Delete", for: .normal)
        cell.btnFavorite.setTitleColor(UIColor.red, for: .normal)
        cell.btnFavorite.tag = indexPath.row
        return cell;
        
        
        
        
        
        
        
    }
    
    func pressedDelete(button: UIButton) {
        
        let index  = button.tag
        
        let item = itemsArray[index]
        
      
        
        let alert = UIAlertController(title: "Confirm", message:"Are You Sure You Want To Delete Item" , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {(alert :UIAlertAction!) in
            ItemUtilityClass.sharedInstance.removeItem(itemToRemove: item)
            self.itemsArray.remove(at: index)
            self.myTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)

        
        
               print (item)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 320.0
        
        
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
