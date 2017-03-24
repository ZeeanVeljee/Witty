//
//  CreateAccountViewController.swift
//  Witty
//
//  Created by Zeean Veljee on 17/04/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var createAcctBtn: UIButton!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        let bottomColour = UIColor(red: 0/255.0, green: 51/255.0, blue: 102/255.0, alpha: 1.0)
        let topColour = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        
        let gradientColours: [CGColor] = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        createAcctBtn.layer.cornerRadius = 15
        createAcctBtn.clipsToBounds = true
        createAcctBtn.backgroundColor = UIColor.clear
        createAcctBtn.titleLabel?.textColor = UIColor.white
        createAcctBtn.layer.borderWidth = 1.0
        createAcctBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        
        cancelBtn.layer.cornerRadius = 15
        cancelBtn.clipsToBounds = true
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.titleLabel?.textColor = UIColor.white
        cancelBtn.layer.borderWidth = 1.0
        cancelBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
    }

    

    @IBAction func createAccount(_ sender: AnyObject) {
        
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" {
            FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: {(user, error) in
                if error != nil {
                    let alertMessage = UIAlertController(title: "Error", message: "Invalid credentials. Try again", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertMessage.addAction(okAction)
                    self.present(alertMessage, animated: true, completion: nil)
                    }
                else {
                    FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: {(authData, err) in
                        let user = ["provider": authData!.providerID, "email": email!, "username": username!]
                        
                        DataService.dataService.createNewAccount((authData?.uid)!, user: user)
                    })
                    UserDefaults.standard.setValue(username, forKey: "uid") //username isntead of result["uid"]
                    self.performSegue(withIdentifier: "NewUserLoggedIn", sender: nil)
                }
            })
        }
        else {
            let alertMessage = UIAlertController(title: "Error", message: "Please enter all credentials", preferredStyle: .alert)
            let okAction  = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
        
    }
    
    
   
    @IBAction func cancelCreateAccount(_ sender: AnyObject) {
         self.dismiss(animated: true, completion: {})
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
