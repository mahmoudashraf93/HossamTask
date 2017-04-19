//
//  FavoritesViewController.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/10/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate , UITableViewDataSource {
    var itemsArray : Array<Item> = []
    @IBOutlet var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "HistoryCell", bundle:nil)
        self.myTableView.register(nibName, forCellReuseIdentifier: "HistoryCell")
        self.itemsArray = ItemUtilityClass.sharedInstance.getAllFavorites()
        self.myTableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if item.isLiked {
            
            cell.btnFavorite.backgroundColor = UIColor.red
            
            
        }
        else{
            cell.btnFavorite.backgroundColor = UIColor.black
            
            
            
        }
        
        cell.btnFavorite.addTarget(self,  action: #selector(pressedFavorite(button:)), for: .touchUpInside)
        cell.btnFavorite.tag = indexPath.row
        return cell;
        
        
        
        
        
        
        
    }
    
    func pressedFavorite(button: UIButton) {
        
        let index  = button.tag
        
        let item = itemsArray[index]
        
        let cell = self.myTableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! HistoryCell
        
        if item.isLiked {
            
            cell.btnFavorite.backgroundColor = UIColor.black
            ItemUtilityClass.sharedInstance.unfavoriteItem(itemToUnFav: item)
            itemsArray.remove(at: index)
            self.myTableView.reloadData()
            
        }
        else{
            
            cell.btnFavorite.backgroundColor = UIColor.red
            ItemUtilityClass.sharedInstance.favoriteItem(itemToFav: item)
            
            
        }
        print (item)
        
    }

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 320.0
        
        
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
