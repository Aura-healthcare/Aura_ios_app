import Foundation

// Protocol
protocol ConnectionDevicePresenter {
    func scan()
}

protocol ConnectionDeviceView {
    func scanHasBeenLaunched()
    func scanHasBeenStopped()
    func devicesFounded(devices : [DeviceViewModel])
}

protocol ConnectionDeviceRepository {
    func getDevices() -> [Device]
}

// Implementation
class ConnectionDevicePresenterImpl : ConnectionDevicePresenter {
    internal var iView: ConnectionDeviceView
    internal var iRepository: ConnectionDeviceRepository
    
    init(iView: ConnectionDeviceView, iRepository: ConnectionDeviceRepository) {
        self.iView = iView
        self.iRepository = iRepository
    }
    
    func scan() {
        iView.scanHasBeenLaunched()
        let devices = iRepository.getDevices()
        if (!devices.isEmpty) {
            iView.devicesFounded(devices: devices.map({ (it) -> DeviceViewModel in
                DeviceViewModel(name: it.name,
                                address: "XX:XX:XX:XX:XX",
                                deviceLogo: "icon_pairing_symbol_neutral",
                                deviceTypeLogo: it.typeToDeviceTypeLogo())
                })
            )
        }
        iView.scanHasBeenStopped()
    }
}
