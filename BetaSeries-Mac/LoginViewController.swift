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
    @IBAction func ConnectionButtonClick(_ sender: NSButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
//
//        print("LoginView")
//        let client:BetaSeriesClient = BetaSeriesClient(username: "Vico1993", password: "victor1993", ApiKey: "ee7422ce11a2")
//        print("After Init")
//        print( client.token )
//        client.GetListSeries()
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
