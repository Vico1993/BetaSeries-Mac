//
//  ToolBox.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 22/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Foundation
import Cocoa

// Config Application
struct Config {
    static let base_url = "https://api.betaseries.com/"
    static let api_key = "ee7422ce11a2"
}

func var_dump(_ data:[String:Any] ) {
    data.forEach({ (key:String, val:Any) in
        print( "Key : \(key) ---> Value : \(val)" )
    })
}

func convertStringToDictionary(json: String) -> [String: AnyObject]? {
    if let data = json.data(using: String.Encoding.utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
        } catch {
            print( "Error Parsing Json" )
        }
    }
    return nil
}

extension NSMutableURLRequest {
    func debugHttpBody ( ) -> String {
        return String(data: httpBody!, encoding: String.Encoding.utf8) as String!
    }
}

extension String {
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
}


// MARK Handle : CoreData
func saveInCordata( entity:String, param:String, IndexPath:String ) -> Bool {
    
    // Save Data
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: entity, in: context)!
    let BetaClient = NSManagedObject(entity: entity, insertInto: context)
    
    BetaClient.setValue(param, forKeyPath: IndexPath)
    
    do {
        try context.save()
        return true
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
    
    return false
}

func getFromCoreData( withEntity:String ) -> Any {
    
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>( entityName: withEntity )
    
    do {
        return try context.fetch( fetchRequest )
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }

    return false
}

func cleanCoreData ( withEntity:String ) -> Bool {
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: withEntity)
    let request = NSBatchDeleteRequest(fetchRequest: fetch)
    
    do {
        try context.execute(request)
        return true
    } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
    }
    return false
}


// LoadViewController
func loadAnController( identfier:String ) -> NSViewController {
    let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
    let identifier = NSStoryboard.SceneIdentifier(rawValue: identfier)
    
    let identifierString = identifier._rawValue
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? NSViewController else {
        fatalError("Can't find my controller... \(identifierString)")
    }
    return viewcontroller
}

// Change ViewController
func changeViewWith( identifer:String ) {
    let appDelegate = NSApplication.shared.delegate as! AppDelegate
    do {
        appDelegate.popover.contentViewController = loadAnController(identfier: identifer)
    } catch let error as NSError {
        print("Could not change of View. \(error), \(error.userInfo)")
    }
}
