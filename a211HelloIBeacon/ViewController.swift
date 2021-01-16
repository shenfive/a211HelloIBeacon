//
//  ViewController.swift
//  a211HelloIBeacon
//
//  Created by 申潤五 on 2021/1/16.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var label1: UILabel!
    var locationMgr:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMgr = CLLocationManager()
        locationMgr.delegate = self
        locationMgr.requestAlwaysAuthorization()
        monitorBeacons()
    }
    func monitorBeacons() {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if let proximityUUID = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"){
                let region = CLBeaconRegion(uuid: proximityUUID, major: 3736, identifier: "beaconID")
                locationMgr.startMonitoring(for: region)
                locationMgr.startRangingBeacons(in: region  as! CLBeaconRegion)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter region")
     }
     func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit region")
     }
      func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
          print("start Region")
      }

    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for beacon in beacons{
            print(beacon.proximityUUID, beacon.major, beacon.minor, beacon.accuracy)
            if beacon.minor == 3301 {
                label1.text = "\(beacon.accuracy)"
            }
        }
    }
    
}



