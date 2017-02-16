//
//  ViewController.swift
//  ILearnNSCoding
//
//  Created by Vladimir Nevinniy on 16.02.17.
//  Copyright © 2017 Vladimir Nevinniy. All rights reserved.
//

import UIKit

class MyObject: NSObject, NSCoding, NSCopying {
    var number = 0
    var string = ""
    var child: MyObject?
    
    override init() {
        
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(string, forKey: "stringKey")
        aCoder.encode(number, forKey: "intKey")
        if let myChild = child {
            aCoder.encode(myChild, forKey: "childKey")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        string = aDecoder.decodeObject(forKey: "stringKey") as! String
        number = Int(aDecoder.decodeInt32(forKey: "intKey"))
        child = aDecoder.decodeObject(forKey: "childKey") as? MyObject
        
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = MyObject()
        copy.number = number
        copy.string = string
        copy.child = child?.copy() as? MyObject
        
        return copy
    }
}


class ViewController: UIViewController {
    
    
    @IBOutlet weak var stringTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var stringChildTextField: UITextField!
    @IBOutlet weak var numberChildTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - Arhiver and Save data
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        let documentDirectory = paths[0] as NSString
        
        return documentDirectory.appendingPathComponent("data.archive") as String
    }
    
    
    func save(object: MyObject)  {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(object, forKey: "keyValueString")
        archiver.finishEncoding()
        
        let path = dataFilePath()
        print(path)
        data.write(toFile: path, atomically: true)
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        
        let object = MyObject()
        
        object.string = stringTextField.text!
       
        
        if let number = Int(numberTextField.text!) {
            object.number = number
        }
        
        if stringChildTextField.text != "" {
            let childObject = MyObject()
            
            childObject.string = stringChildTextField.text!
            if let number = Int(numberChildTextField.text!) {
                object.number = number
            }
            
            childObject.child = childObject
        }
        
        save(object: object)
        
        stringTextField.text = ""
        numberTextField.text = ""
        
        stringChildTextField.text = ""
        numberChildTextField.text = ""
        
        
    }
    
    

}

