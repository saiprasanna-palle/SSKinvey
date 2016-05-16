//
//  CreateVC.swift
//  kinvey
//
//  Created by AppCenter on 3/4/16.
//  Copyright © 2016 AppCenter. All rights reserved.
//

import UIKit

class  CreateVC : UIViewController,UIPickerViewDataSource,UIPickerViewDelegate
{
     let pickerData = ["Oklahoma State University","University of Oklahoma"]
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var name: UITextField!
    var pickers : String?
    var user: User!
    var university: University!
         var universities : [University]!
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        picker.dataSource = self
        picker.delegate = self
    }
    
    
    func requestAllElements() {
        
        
        let collection = KCSCollection(fromString: "Universities", ofClass: University.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        store.queryWithQuery(KCSQuery(),
            
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil == nil {
                    NSLog("successful reload: \(objectsOrNil.count)") // frst object
                   self.universities = objectsOrNil as! [University]
                    
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil)
        
        print("Unis retrieved : \(universities.count)")

        }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickers = pickerData[row]
        self.university = self.universities[self.picker.selectedRowInComponent(0)]
    }
    
    
    @IBAction func saveB(sender: AnyObject) {
        
        var objid : Int?
        
        let nm = name.text
        var usrnm = username.text
        var email = self.email.text
        var pwd = password.text
        var unis = pickers
        
        let collection = KCSCollection(fromString: "Universities", ofClass: University.self)
        let store = KCSAppdataStore(collection: collection, options: nil)
        
        let query = KCSQuery(onField: "name", withExactMatchForValue: "university of oklahoma")
        
        store.queryWithQuery(
            query,
            withCompletionBlock: {
                
                (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil == nil {
                    NSLog("successfully loaded objects: %@", objectsOrNil)
                    
                } else {
                    NSLog("error occurred: %@", errorOrNil)
                }
            },
            withProgressBlock: nil
        )
        
        
    user.username = usrnm
        user.password = pwd
        user.email = email
        user.givenName = nm
      //  user.uni = universityPointer
        //let universityPointer = PFObject(withoutDataWithClassName: "University", objectId: self.university?.objectId)
        
    KCSUser.userWithUsername(
    usrnm,
    password: pwd,
        fieldsAndValues: [
            KCSUserAttributeEmail : email!,
            KCSUserAttributeGivenname : nm!,
        ],
    withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
    if errorOrNil == nil {
    //was successful!
    let alert = UIAlertView(
    title: NSLocalizedString("Account Creation Successful", comment: "account success note title"),
    message: NSLocalizedString("User created. Welcome!", comment: "account success message body"),
    delegate: nil,
    cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
    )
    alert.show()
    } else {
    //there was an error with the update save
    let message = errorOrNil.localizedDescription
    let alert = UIAlertView(
    title: NSLocalizedString("Create account failed", comment: "Create account failed"),
    message: message,
    delegate: nil,
    cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
    )
    alert.show()
    }
    }
    )
        
    }
    
}
