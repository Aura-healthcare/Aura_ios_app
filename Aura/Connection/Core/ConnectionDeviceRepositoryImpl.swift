import Foundation
import VivalnkSDK

class ConnectionDeviceRepositoryImpl : NSObject, ConnectionDeviceRepository, vlBLEDelegates {
    
    private let manager = VVBleManager.shareInstance()
    private var deviceFoundCallback: ((Device) -> Void)? = nil
    
    func initialize() {
        manager?.bleReconnectEnabled = true
        manager?.delegate = self
        manager?.connectDelegate = self
        manager?.scanDelegate = self
        manager?.bleStateDelegate = self
        
        let statusCode = manager?.checkBle()
        /*
         Bluetooth State code | Definition
         0 | Unknown
         1 | Resetting
         2 | Unsupported
         3 | Unauthorized
         4 | PoweredOff
         5 | PoweredOn
         */
        print (String(describing: statusCode))
    }
    
    func getDevices(deviceFoundCallback: @escaping (Device) -> Void) {
        self.deviceFoundCallback = deviceFoundCallback
        startScan()
    }
    
    func startScan() {
        let option = VVToolUseClass()
        option.scanTimeout = 1000*60
        manager?.startScan(option, with: ScanDeviceType.VitalDevice)
    }
    
    func stopScan() {
        manager?.stopScan()
    }
    
    func connect(deviceId: String) {
        let device = VVToolUseClass()
        device.name = deviceId
        device.connectTimeout = 1000*30
        device.connectRetry = 1000
        manager?.connect(device)
     }
}

extension ConnectionDeviceRepositoryImpl : BluetoothStateListenerDelegate {
    func onBluetoothOpen() {
        print("Bluetooth open")
    }
    
    func onBluetoothClose() {
        print("Bluetooth closed")
    }
    
    func onBluetoothSwitchToOnStatus() {
        print("Bluetooth switchToOnStatus")
    }
}

extension ConnectionDeviceRepositoryImpl : BluetoothScanListenerDelegate {
    func onScanStart() {
        print("Bluetooth scan start")
    }
    
    func onScanError(_ code: Int32, _ msg: String!) {
        print("Bluetooth scan error \(code) \(String(describing: msg))")
    }
    
    func onScanStop() {
        print("Bluetooth scan stop")
    }
    
    func onDeviceFound(_ device: VVToolUseClass!) {
        print("Bluetooth device found: \(String(describing: device.name))")
        deviceFoundCallback?(
            Device(
                name: device.name,
                type: .HEART
            )
        )
    }
}

extension ConnectionDeviceRepositoryImpl : BluetoothConnectListenerDelegate {
    func onConnected(_ device: VVToolUseClass!) {
        print("Connected to device: \(String(describing: device.name))")
    }
}
