//
//  Note.swift
//  parseSampleApplication
//
//  Created by Alexander Karpov on 05.02.16.
//  Copyright © 2016 Alex Karpov. All rights reserved.
//

import UIKit
import Parse
class Note: NSObject {
    
    var title : String?
    var text : String!
    var objectId : String?
    
    init(parseObject: PFObject) {
        super.init()
        title = parseObject["title"] as? String
        text = parseObject["text"] as! String
        objectId = parseObject.objectId
    }
    
    init(title: String?, text: String) {
        self.title = title
        self.text = text
    }
    
    var parseObject: PFObject {
        let newObj = PFObject(className: "Note") 
        if let t = title {
            newObj["title"] = t
        }
        newObj["text"] = text
        
        if let id = objectId { 
            newObj.objectId = id 
        }
        
        return newObj
    }
    
    func save(success successHandler: (Void->Void)? = nil, error errorHandler: (String->Void)? = nil) {
        parseObject.saveInBackgroundWithBlock { 
            (success, error) in
            if success {
                successHandler?()
            } else {
                if let e = error {
                    errorHandler?(e.localizedDescription)
                } else {
                    errorHandler?("Unknown error")
                }
            }
        }
    }
    
    func deleteFromParse(success successHandler: (Void->Void)? = nil, error errorHandler: (String->Void)? = nil) {
        parseObject.deleteInBackgroundWithBlock { 
            (success, error)  in
            if success {
                successHandler?()
            } else {
                if let e = error {
                    errorHandler?(e.localizedDescription)
                } else {
                    errorHandler?("Unknown error")
                }
            }
        }
    }
    
}
