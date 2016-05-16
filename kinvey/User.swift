//
//  User.swift
//  kinvey
//
//  Created by AppCenter on 3/4/16.
//  Copyright © 2016 AppCenter. All rights reserved.
//

import UIKit

class User : KCSUser
{
   
   // var University : KCSCollection
    
    var entityId: String? //Kinvey entity _id
    var uni: University? //Kinvey entity _id

    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "uni" : "uni"
        ]
    }
    
    override init() {
    
    }
    
    internal static override func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "Universities" /* backend field name */ : "Invitations" /* collection name for invitations */
        ]
    }
    internal static override func kinveyObjectBuilderOptions() -> [NSObject : AnyObject]! {
        // reference class map - maps properties to objects
        return [
            KCS_REFERENCE_MAP_KEY : [
                "uni" : University.self
            ]
        ]
    }
    
}
