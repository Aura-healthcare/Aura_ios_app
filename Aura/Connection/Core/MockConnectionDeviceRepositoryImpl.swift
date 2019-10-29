import Foundation

class MockConnectionDeviceRepositoryImpl : ConnectionDeviceRepository {
    
    func initialize() {
        /* do nothing */
    }
    
    func getDevices(deviceFoundCallback: @escaping (Device) -> Void) {
        sleep(1)
        deviceFoundCallback(Device(name: "Polar H10 2E0E2A28", type: .HEART))
        sleep(1)
        deviceFoundCallback(Device(name: "MetaWear", type: .GYRO))
        sleep(1)
        deviceFoundCallback(Device(name: "MAXREFDES73#", type: .SKIN))
    }
    
    func connect(deviceId: String) {
        /* do nothing */
    }
}
