//
//  ViewController.swift
//  Witty
//
//  Created by Zeean Veljee on 17/04/16.
//  Copyright © 2016 Zed. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class LogInViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
       let bottomColour = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        let topColour = UIColor(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        
        let gradientColours: [CGColor] = [topColour.cgColor, bottomColour.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        gradientLayer.colors = gradientColours
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
       
    }
    
    override func viewDidLayoutSubviews() {
        logInBtn.layer.cornerRadius = 15
        logInBtn.clipsToBounds = true
        logInBtn.backgroundColor = UIColor.clear
        logInBtn.titleLabel?.textColor = UIColor.white
        logInBtn.layer.borderWidth = 1.0
        logInBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
        
        signUpBtn.layer.cornerRadius = 15
        signUpBtn.clipsToBounds = true
        signUpBtn.backgroundColor = UIColor.clear
        signUpBtn.titleLabel?.textColor = UIColor.white
        signUpBtn.layer.borderWidth = 1.0
        signUpBtn.layer.borderColor = UIColor(white: 1.0, alpha: 0.7).cgColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if UserDefaults.standard.value(forKey: "uid") != nil /*&& DataService.dataService.CURRENT_USER_REF.authData != nil*/ {
            self.performSegue(withIdentifier: "CurrentlyLoggedIn", sender: nil)
        }
    }

    @IBAction func tryLogin(_ sender: AnyObject) {
        print("HERE")
        let email = emailField.text
        let password = passwordField.text
        
        if email != "" && password != "" {
            FIRAuth.auth()?.signIn(withEmail: email!, password: password!, completion: {(authData, error) in
                if error != nil {
                    print(error)
                    let alertMessage = UIAlertController(title: "Error", message: "Invalid Credentials. Try again", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertMessage.addAction(okAction)
                    self.present(alertMessage, animated: true, completion: nil)
                }
                else {
                    UserDefaults.standard.setValue(authData?.uid, forKey: "uid")
                    
                    self.performSegue(withIdentifier: "CurrentlyLoggedIn", sender: nil)
                }
            })
            
        }
        else {
            let alertMessage = UIAlertController(title: "Error", message: "Enter all credentials", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMessage.addAction(okAction)
            self.present(alertMessage, animated: true, completion: nil)
        }
    }

}

