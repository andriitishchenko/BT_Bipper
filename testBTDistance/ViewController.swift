//
//  ViewController.swift
//  testBTDistance
//
//  Created by Andrii Tischenko on 1/22/19.
//  Copyright © 2019 Andrii Tischenko. All rights reserved.
//

import Cocoa

import CoreBluetooth

class ViewController: NSViewController,// CBPeripheralManagerDelegate,
CBCentralManagerDelegate, CBPeripheralDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    manager = CBCentralManager(delegate: self, queue: nil)
    // Do any additional setup after loading the view.
    scanBLEDevice()
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  
  var peripherals:[CBPeripheral] = []
  var manager: CBCentralManager? = nil
  
  func scanBLEDevice(){
    print("scan start")
    manager?.scanForPeripherals(withServices: nil, options: nil)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
      self.stopScanForBLEDevice()
    }
    
  }
  func stopScanForBLEDevice(){
    manager?.stopScan()
    print("scan stopped")
    scanBLEDevice()
  }
  
  // Invoked when the central manager discovers a peripheral while scanning.
  func centralManager(_ manager: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData advertisement: [String : Any], rssi: NSNumber) {
    if let name = peripheral.name {
      let faktor:Double = 2.0
      let mpower:Double = -69.0
      let d:Double = pow(10.0, (mpower - rssi.doubleValue) / (10.0 * faktor) )

      print("Found \"\(name)\" peripheral (RSSI: \(rssi)) Dist: \(d)")
    }
//    RSSI[dbm] = −(10n log10(d) − A)
//    https://iotandelectronics.wordpress.com/2016/10/07/how-to-calculate-distance-from-the-rssi-value-of-the-ble-beacon/
  }
  
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    print(central.state)
  }
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//    peripheral.delegate = self
//    peripheral.discoverServices(nil)
//    print("Connected to "+peripheral.name!)
  }
  
  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    print(error!)
  }
}

