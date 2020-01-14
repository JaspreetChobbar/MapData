//
//  Edit.swift
//  MapDemo
//
//  Created by MacStudent on 2020-01-14.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit

class Edit: UIViewController {
    
    @IBOutlet weak var title1: UITextField!
    @IBOutlet weak var subtitle1: UITextField!
    @IBOutlet weak var lat1: UITextField!
    @IBOutlet weak var lon1: UITextField!
    
    var index = 0
    var locpoints = [LocationPoints]()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locpoints = appdelegate.fetchRecords()
        
        title1.text = locpoints[index].title
        subtitle1.text = String(locpoints[index].subTitle)
        lat1.text = String(locpoints[index].latitude)
        lon1.text = String(locpoints[index].longitude)
        
    }
    
    @IBAction func delete_btn(_ sender: Any) {
        
         appdelegate.deleteRecord(locpoints: locpoints[index])
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func update_btn(_ sender: Any) {
        
        appdelegate.updateRecord(locpoints : locpoints[index],title: title1.text!, subTitle: Int32(subtitle1.text!)!, latitude: Double(lat1.text!)!,longitude: Double(lon1.text!)!  )
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
}
