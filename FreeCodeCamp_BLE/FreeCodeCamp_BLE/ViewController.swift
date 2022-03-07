//
//  ViewController.swift
//  FreeCodeCamp_BLE
//
//  Created by Jacob Case on 3/3/22.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    
    
    @IBOutlet weak var Update: UIButton!
    var centralManager: CBCentralManager!
    var peripherals = [CBPeripheral]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    @IBAction func Update(_ sender: Any) {
        print("re-running didUpdateString on CB")
        centralManagerDidUpdateState(centralManager)

        
    }
    
    func startScanning() -> Void {
      // Start Scanning
        centralManager.scanForPeripherals(withServices: nil, options: nil)
    }
    

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
            self.view.backgroundColor = .gray
        case .poweredOn:
            print("Is Powered On.")
            self.view.backgroundColor = .blue
            startScanning()
            print("scanning")
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
            print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {

        print("here")
        // We've found it so stop scan
        self.centralManager.stopScan()
        print("stop scan")

        
        print("Peripheral: \(peripheral)\n\n")
        print("RSSI: \(RSSI)\n\n")
        print("Advert data: \(advertisementData)\n\n")
        print(peripheral.state)

    }
    
}

