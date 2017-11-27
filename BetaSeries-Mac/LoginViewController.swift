//
//  LoginViewController.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 22/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Cocoa

class LoginViewController: NSViewController {

    @IBOutlet weak var UsernameInput: NSTextField!
    @IBOutlet weak var PasswordInput: NSSecureTextField!
    @IBOutlet weak var ErrorInput: NSTextField!
    @IBOutlet weak var ConnectionButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // Hidding the ErrorLabel at the begining.
        ErrorInput.isHidden = true
    }
    
    @IBAction func ConnectionButtonClick(_ sender: NSButton) {
        ErrorInput.isHidden = true
        
        let username = UsernameInput.stringValue
        let password = PasswordInput.stringValue
        
        if username != "" && password != "" {
            let client:BetaSeriesClient = BetaSeriesClient(username: username, password: password)
            
            if client.IsConnect() {
                // Save Data
                if saveInCordata(entity: "BetaClient", param: client.token, IndexPath: "token") {
                    // change of view
                } else {
                    ErrorInput.stringValue = "Something Append, Check the log.."
                    ErrorInput.isHidden = false
                }
            } else {
                ErrorInput.stringValue = "Error append with your credentials. Please Check and try again."
                ErrorInput.isHidden = false
            }
        } else {
            ErrorInput.stringValue = "Thanks to check your username and password."
            ErrorInput.isHidden = false
        }
        
        print( "Username = \(username)" )
        print( "Password = \(password)" )
    }
    
}

extension LoginViewController {
    // Test si Connecter ici ???
    static func freshController() -> LoginViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "LoginViewController")
        
        let identifierString = identifier._rawValue
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? LoginViewController else {
            fatalError("Can't find my controller... \(identifierString)")
        }
        return viewcontroller
    }
}
