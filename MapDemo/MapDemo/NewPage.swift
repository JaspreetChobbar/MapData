//
//  NewPage.swift
//  MapDemo
//
//  Created by MacStudent on 2020-01-13.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit

class NewPage: UIViewController {
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var title1: UITextField!
    @IBOutlet weak var subTitle1: UITextField!
    @IBOutlet weak var latitude1: UITextField!
    @IBOutlet weak var longitude1: UITextField!
    
    @IBAction func save(_ sender: Any) {
        
        self.appdelegate.insertRecord(title: title1.text!, subTitle: Int32(subTitle1.text!)!, latitude: Double(latitude1.text!)!,longitude: Double(longitude1.text!)!  )
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
}
