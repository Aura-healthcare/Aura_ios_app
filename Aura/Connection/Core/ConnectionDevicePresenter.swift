import Foundation

// Protocol
protocol ConnectionDevicePresenter {
    func viewDidLoad()
    func scan()
    func didSelect(device: DeviceViewModel)
}

protocol ConnectionDeviceView {
    func scanHasBeenLaunched()
    func scanHasBeenStopped()
    func devicesFounded(with device : DeviceViewModel)
}

protocol ConnectionDeviceRepository {
    func initialize()
    func getDevices(deviceFoundCallback: @escaping (Device) -> Void)
    func connect(deviceId: String)
}

// Implementation
class ConnectionDevicePresenterImpl : ConnectionDevicePresenter {
    internal var view: ConnectionDeviceView
    internal var repository: ConnectionDeviceRepository
    
    init(view: ConnectionDeviceView, repository: ConnectionDeviceRepository) {
        self.view = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        repository.initialize()
    }
    
    func scan() {
        view.scanHasBeenLaunched()
        repository.getDevices { (newDevice) in
            self.view.devicesFounded(with:
                DeviceViewModel(
                    name: newDevice.name,
                    address: "XX:XX:XX:XX:XX",
                    deviceLogo: "icon_pairing_symbol_neutral",
                    deviceTypeLogo: newDevice.typeToDeviceTypeLogo()
                )
            )
            self.view.scanHasBeenStopped()
        }
    }
    
    func didSelect(device: DeviceViewModel) {
        repository.connect(deviceId: device.name) // TODO PBA
    }
}
