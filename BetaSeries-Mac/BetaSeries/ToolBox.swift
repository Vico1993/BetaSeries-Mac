//
//  ToolBox.swift
//  BetaSeries-Mac
//
//  Created by Victor Piolin on 22/11/2017.
//  Copyright © 2017 Victor Piolin. All rights reserved.
//

import Foundation

func var_dump(_ data:[String:Any] ) {
    data.forEach({ (key:String, val:Any) in
        print( "Key : \(key) ---> Value : \(val)" )
    })
}

extension NSMutableURLRequest {
    func debugHttpBody ( ) -> String {
        return String(data: httpBody!, encoding: String.Encoding.utf8) as String!
    }
}

extension String {
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.dealloc(digestLen)
        
        return String(format: hash as String)
    }
}
