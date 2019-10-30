import Foundation

class MockConnectionDeviceRepositoryImpl : ConnectionDeviceRepository {
    var deviceFoundCallback: ((Device) -> Void)? = nil
    
    func initialize() {
        /* do nothing */
    }
    
    func startScan() {
        sleep(1)
        deviceFoundCallback?(Device(name: "Polar H10 2E0E2A28", type: .HEART))
        sleep(1)
        deviceFoundCallback?(Device(name: "MetaWear", type: .GYRO))
        sleep(1)
        deviceFoundCallback?(Device(name: "MAXREFDES73#", type: .SKIN))
    }
    
    func connect(deviceName: String) {
        /* do nothing */
    }
    
    func stopScan() {
        /* do nothing */
    }
}
