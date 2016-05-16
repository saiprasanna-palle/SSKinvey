//
//  ViewController.swift
//  kinvey
//
//  Created by AppCenter on 3/3/16.
//  Copyright © 2016 AppCenter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var nm: UITextField!
    @IBOutlet weak var name: UILabel!
         var universities : [University]!
    
    @IBAction func loginbut(sender: AnyObject) {
        
        var nm = self.name.text
        var pwd = pass.text
        
        KCSUser.loginWithUsername(
            "pras29",
            password: "12345",
            withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    //the log-in was successful and the user is now the active user and credentials saved
                    //hide log-in view and show main app content
                    print("login success")
                } else {
                    //there was an error with the update save
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Login failed", comment: "Sign account failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
              
                }
            }
        )
        
    }
    
    
    
    @IBAction func createbut(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        if KCSUser.activeUser() == nil
        {
             name.text = "Active User : Nil"
            
            
            KCSUser.loginWithUsername(
                "pras29",
                password: "12345",
                withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                    if errorOrNil == nil {
                        //the log-in was successful and the user is now the active user and credentials saved
                        //hide log-in view and show main app content
                        print("login success")
                    } else {
                        //there was an error with the update save
                        let message = errorOrNil.localizedDescription
                        let alert = UIAlertView(
                            title: NSLocalizedString("Login failed", comment: "Sign account failed"),
                            message: message,
                            delegate: nil,
                            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                        )
                        alert.show()
                    }
                }
            )
        }
        else
        {
            print("Active user : \(KCSUser.activeUser().username)")
            name.text = "Active User : \(KCSUser.activeUser().username)"
        }
        
       // let collection = KCSCollection(fromString: "Universities", ofClass: Universities.self) //load the data from the values collection
      //  let store = KCSCachedStore(collection: collection, options: [ KCSStoreKeyCachePolicy : KCSCachePolicy.LocalFirst.rawValue ])
  
        print("iam here")
      /*  let store = KCSAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Universities",
            KCSStoreKeyCollectionTemplateClass : Universities.self
            ])  */
     

        
        let collection = KCSCollection(fromString: "Universities", ofClass: University.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.queryWithQuery(KCSQuery(),
            
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil == nil {
                    NSLog("successful reload: \(objectsOrNil.count)") // frst object
                    let uni = University()
                    print(uni.name)
                    
                              self.universities = objectsOrNil as! [University]
                            print("Unis retrieved : \(self.universities.count)")
                    
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
        },
            withProgressBlock: nil)
        
        
        print("After retrieving universities")
        
       var id = KCSUser.activeUser().kinveyObjectId()
        print(id)
        
        var  user = User()
        user.uni = self.universities[0]
        user.entityId = id
        
        let collection1 = KCSCollection(fromString: "Users", ofClass: User.self)
        let store1 = KCSAppdataStore(collection: collection, options: nil)
        
        store1.saveObject(
            user,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    //save failed
                    NSLog("Save failed on object")
                } else {
                    //save was successful
                    NSLog("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                }
            },
            withProgressBlock: nil
        )
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

