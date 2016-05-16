//
//  Universities.swift
//  kinvey
//
//  Created by AppCenter on 3/3/16.
//  Copyright © 2016 AppCenter. All rights reserved.
//

import UIKit

class University :NSObject  //all NSObjects in Kinvey implicitly implement KCSPersistable

{
    var entityId: String? //Kinvey entity _id
    var name: String? //Kinvey entity _id
    var place: String?
    var metadata: KCSMetadata? //Kinvey metadata, optional
    
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "place" : "place",
            "metadata" : KCSEntityKeyMetadata //optional _metadata field
        ]
    }

}