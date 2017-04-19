//
//  LoginViewController.swift
//  HossamTask
//
//  Created by mahmoud salah on 4/10/17.
//  Copyright © 2017 mahmoud. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import SDWebImage


class LoginViewController: UIViewController {
    
    var dict = [String : AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.darkGray
        myLoginButton.frame = CGRect(x:0, y:0, width:180, height: 40);
        myLoginButton.center = view.center;
        myLoginButton.title(for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self,  action: #selector(btnFBLoginPressed(_ :)), for: .touchUpInside)
        
        view.addSubview(myLoginButton)
        let defaults = UserDefaults.standard
        
        let isLoggedIn = defaults.bool(forKey: "isLoggedIn")
        if isLoggedIn{
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "segueLogin", sender: self)

            }

            
            
        }
        // Do any additional setup after loading the view.
    }
    
  
    
    func btnFBLoginPressed(_ sender: AnyObject) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    
                    if  let pictDict = self.dict["picture"]{
                        if let dataDict = pictDict["data"] as? [String: Any] {
                            if let urllll = dataDict["url"] as? String {
                                
                                if let url = NSURL(string: urllll ){
                                    if let data = NSData(contentsOf: url as URL) {
                                        
                                        let user = User(entity: Constants.ENTITYUSER,
                                                        insertInto: Constants.MANAGEDCONTEXT)
                                        user.name = self.dict["first_name"] as! String?
                                        user.image = data
                                        
                                        ItemUtilityClass.sharedInstance.saveToCoreData()
                                        
                                    }
                                }
                                
                                
                                
                            }
                        }
                        
                    }
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "isLoggedIn")


                 self.performSegue(withIdentifier: "segueLogin", sender: nil)
                }
                
                else {
                    let alert = UIAlertController(title: "Error", message: error as! String? , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                
                
                }
            })
        }
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
