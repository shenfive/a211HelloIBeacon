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
    var locationView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        locationView.backgroundColor = UIColor.red
        view.addSubview(locationView)
        
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
        let content = UNMutableNotificationContent()
         content.title = "歡迎光臨"
         content.subtitle = "我們的家"
         content.badge = 1
         content.sound = UNNotificationSound.default
         let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

     }
     func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let content = UNMutableNotificationContent()
         content.title = "謝謝光臨"
         content.subtitle = "我們的家"
         content.badge = 1
         content.sound = UNNotificationSound.default
         let request = UNNotificationRequest(identifier: "notification", content: content, trigger: nil)
         UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
     }
      func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
          print("start Region")
      }

    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        let c = 2.0
        var a = 0.0
        var b = 0.0
        
        
        for beacon in beacons{
            
            print("beacon:\(beacon.minor):\(beacon.accuracy)")
            
            
            
            if beacon.minor == 3301 {
                a = Double(beacon.accuracy)
            }
            
            if beacon.minor == 3305 {
                b = Double(beacon.accuracy)
            }
        
        }
        
        // c 為 Beacon1 與 Beacon 2 的距離，a 為  手機與 Beacon1 的 距離，b 為 Beacon2 的
        var s = ( a + b + c ) / 2  //由三角形三邊長取得海龍公司參數，用來計算面積
        var area = sqrt( s * ( s - a ) * ( s - b ) * ( s - c ) )  //取得面積
        let y = area * 2 / c  //由三角形面積估算 Y 座標
        let x = sqrt( ( a * a ) - ( y * y ) ) // 使用畢氏定理（勾股定理）計算 x 座標
        print("x:\(x) y:\(y)")
        
        label1.text = "a:\(a)\nb:\(b)\nx:\(x)\ny:\(y)"
        if x > 0 && y > 0{
            let rect = CGRect(x: x * 250 , y: y * 250, width: 30, height: 30)
            locationView.frame = rect
        }
        
    }
    
}



