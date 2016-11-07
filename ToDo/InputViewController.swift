//
//  InputViewController.swift
//  ToDo
//
//  Created by B1media on 2016/10/13.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()

    
    @IBAction func save() {
        guard let titleString = titleTextField.text
            , titleString.characters.count > 0 else { return }
        let date: Date?
        if let dateText = self.dateTextField.text
            , dateText.characters.count > 0 {
            date = dateFormatter.date(from: dateText)
            
        } else {
            date = nil
        }
        let descriptionString: String?
        if (descriptionTextField.text?.characters.count)! > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        if let locationName = locationTextField.text
            , locationName.characters.count > 0 {
            if let address = addressTextField.text
                , address.characters.count > 0 {
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    let placeMark = placeMarks?.first
                    let item = ToDoItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timestamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName,
                                                           coordinate: placeMark?.location?.coordinate))
                    DispatchQueue.main.async(execute: {
                        () -> Void in
                        self.itemManager?.addItem(item: item)
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                }
                //多加的，書上沒寫
            } else {
                let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName))
                self.itemManager?.addItem(item: item)
                dismiss(animated: true, completion: nil)
            }
            //多加的，書上沒寫
        } else {
            let item = ToDoItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
            self.itemManager?.addItem(item: item)
            dismiss(animated: true, completion: nil)
        }
        
    }
}

