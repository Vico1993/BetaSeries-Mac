//
//  ListShowController.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 27/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Cocoa

class ListShowController: NSViewController {

    var client:BetaSeriesClient? = nil
    @IBOutlet weak var ListShowTable: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        // get client From Token
        let data = getFromCoreData(withEntity: "BetaClient") as! [BetaClient]
        for _data in data {
            if (_data.token != nil) {
                client = BetaSeriesClient(withToken: _data.token! )
            }
        }
    }
    
    
    
}
