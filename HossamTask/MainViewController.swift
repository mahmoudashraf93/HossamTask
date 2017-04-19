//
//  MainViewController.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/9/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit
import SideMenu
import CoreData
import SDWebImage


class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var myTableView: UITableView!
    @IBAction func btnAddItemPressed(_ sender: AnyObject) {
        optionsMenu()
    }
    
    var itemsArray : Array<Item> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        let nibName = UINib(nibName: "HistoryCell", bundle:nil)
        self.myTableView.register(nibName, forCellReuseIdentifier: "HistoryCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.itemsArray = ItemUtilityClass.sharedInstance.getAllItems()
        self.myTableView.reloadData()
        
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.menuAnimationBackgroundColor = UIColor.clear
        
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
            
            cell.btnFavorite.backgroundColor = UIColor.init(colorLiteralRed: 244/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1.0)
            
        }
        else{
            cell.btnFavorite.backgroundColor = UIColor.init(colorLiteralRed: 26/255.0, green: 67/255.0, blue: 1.0, alpha: 1.0)
         
        }
        
        cell.btnFavorite.addTarget(self,  action: #selector(pressedFavorite(button:)), for: .touchUpInside)
        cell.btnFavorite.tag = indexPath.row
        return cell;
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 320.0
        
        
    }
    
    
    
    func pressedFavorite(button: UIButton) {
        
        let index  = button.tag
        
        let item = itemsArray[index]
        
        let cell = self.myTableView.cellForRow(at: IndexPath.init(row: index, section: 0)) as! HistoryCell
        
        if item.isLiked {
            DispatchQueue.main.async {
                     cell.btnFavorite.backgroundColor = UIColor.black
            }
            ItemUtilityClass.sharedInstance.unfavoriteItem(itemToUnFav: item)
            
        }
        else{
            DispatchQueue.main.async {
                cell.btnFavorite.backgroundColor = UIColor.red

            }
            ItemUtilityClass.sharedInstance.favoriteItem(itemToFav: item)
            
            
        }
       
    }
    
    func optionsMenu() {
        
        let camera = Camera(delegate_: self)
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Camera", style: .default) { (alert : UIAlertAction!) in
            camera.presentPhotoCamera(target: self, canEdit: true)
        }
        let sharePhoto = UIAlertAction(title: "Library", style: .default) { (alert : UIAlertAction) in
            camera.presentPhotoLibrary(target: self, canEdit: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction) in
            //
        }
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let item = Item(context:Constants.MANAGEDCONTEXT)
        
        item.details = "Test Test"
        item.timeStamp = Date() as NSDate?
        
        item.ownerName = UserUtilityClass.sharedInstance.getUser().name
        
        item.isLiked = false
        item.title = "User Post"
        
        
        let data = UIImagePNGRepresentation(image) as NSData?
        item.image = data
        
        
        item.ownerImage = UserUtilityClass.sharedInstance.getUser().image
        
        ItemUtilityClass.sharedInstance.saveToCoreData()
        
        picker.dismiss(animated: true, completion: nil)
       tableViewScrollToBottom(animated: true)
    }
    
    func tableViewScrollToBottom(animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
//            let numberOfSections = self.myTableView.numberOfSections
//            let numberOfRows = self.myTableView.numberOfRows(inSection: numberOfSections-1)
//            
//            if numberOfRows > 0 {
//                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
//                self.myTableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
//            }
//        }
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
