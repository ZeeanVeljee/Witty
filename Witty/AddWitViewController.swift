//
//  AddWitViewController.swift
//  Witty
//
//  Created by Zeean Veljee on 01/06/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import UIKit
import Firebase

class AddWitViewController: UIViewController {

    @IBOutlet weak var WitField: UITextField!
    
    fileprivate var currentUserName = DataService.dataService.userID
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       /* DataService.dataService.CURRENT_USER_REF.observeEventType(FIRDataEventType.Value, withBlock:{ snapshot in
            let currentUser = snapshot.value?.objectForKey("username") as! String
            print("Username: \(currentUser)")
            self.currentUserName = currentUser
            }, withCancelBlock:{error in
                print(error.description)
            })*/
        self.view.backgroundColor = UIColor.darkGray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func wit(_ sender: AnyObject) {
        let witText = WitField.text
        
        if witText != "" {
            let newWit: Dictionary<String, AnyObject> = [
            "witText": witText! as AnyObject,
            "votes": 0 as AnyObject,
            "author": currentUserName as AnyObject
            ]
            
            DataService.dataService.createNewWit(newWit)
            
            if let navController = self.navigationController {
                navController.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func logout(_ sender: AnyObject) {
      try! FIRAuth.auth()?.signOut()
        UserDefaults.standard.setValue(nil, forKey: "uid")
        
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        UIApplication.shared.keyWindow?.rootViewController = loginViewController
        
    }
    
    func nullToNil(_ value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
    
    //people.age = nullToNil(peopleDict["age"])
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
