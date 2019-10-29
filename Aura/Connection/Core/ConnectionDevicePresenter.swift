import Foundation

// Protocol
protocol ConnectionDevicePresenter {
    func viewDidLoad()
    func scan()
}

protocol ConnectionDeviceView {
    func scanHasBeenLaunched()
    func scanHasBeenStopped()
    func devicesFounded(with device : DeviceViewModel)
}

protocol ConnectionDeviceRepository {
    func initialize()
    func getDevices(deviceFoundCallback: @escaping (Device) -> Void)
}

// Implementation
class ConnectionDevicePresenterImpl : ConnectionDevicePresenter {
    internal var iView: ConnectionDeviceView
    internal var iRepository: ConnectionDeviceRepository
    
    init(iView: ConnectionDeviceView, iRepository: ConnectionDeviceRepository) {
        self.iView = iView
        self.iRepository = iRepository
    }
    
    func viewDidLoad() {
        iRepository.initialize()
    }
    
    func scan() {
        iView.scanHasBeenLaunched()
        iRepository.getDevices { (newDevice) in
            self.iView.devicesFounded(with:
                DeviceViewModel(name: newDevice.name,
                                address: "XX:XX:XX:XX:XX",
                                deviceLogo: "icon_pairing_symbol_neutral",
                                deviceTypeLogo: newDevice.typeToDeviceTypeLogo())
            )
            self.iView.scanHasBeenStopped()
        }
    }
}
