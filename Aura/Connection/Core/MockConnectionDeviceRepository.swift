import Foundation

class MockConnectionDeviceRepository : ConnectionDeviceRepository {
    func getDevices() -> [Device] {
        sleep(4)
        return [
            Device(name: "Polar H10 2E0E2A28", type: .HEART),
            Device(name: "MetaWear", type: .GYRO),
            Device(name: "MAXREFDES73#", type: .SKIN)
        ]
    }
}
