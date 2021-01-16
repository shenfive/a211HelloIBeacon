//
//  ViewController.swift
//  a211HelloIBeacon
//
//  Created by 申潤五 on 2021/1/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var locationMgr:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationMgr = CLLocationManager()
        locationMgr.delegate = self
        locationMgr.requestAlwaysAuthorization()
        
    }


}

