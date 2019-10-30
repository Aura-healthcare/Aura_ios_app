import Foundation

class MockConnectionDeviceRepositoryImpl : ConnectionDeviceRepository, TrackingRepository {
    var deviceFoundDelegate: ((Device) -> Void)?
    var connectDelegate: ((String) -> Void)?
    var onReceiveDataDelegate: ((String) -> Void)?
    
    func initialize() {
        /* do nothing */
    }
    
    func startScan() {
        sleep(1)
        deviceFoundDelegate?(Device(name: "Polar H10 2E0E2A28", type: .HEART))
        sleep(1)
        deviceFoundDelegate?(Device(name: "MetaWear", type: .GYRO))
        sleep(1)
        deviceFoundDelegate?(Device(name: "MAXREFDES73#", type: .SKIN))
    }
    
    func connect(deviceName: String) {
        connectDelegate?(deviceName)
    }
    
    func stopScan() {
        /* do nothing */
    }
    
    func executeStartSampling() {
        for i in 0...120 {
            onReceiveDataDelegate?("This is mocked data ! Packet n°\(i) ...")
            usleep(500)
        }
    }
}
