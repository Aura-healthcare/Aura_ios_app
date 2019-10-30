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
    func stopScan()
}

// Implementation
class ConnectionDevicePresenterImpl : ConnectionDevicePresenter {
    internal var view: ConnectionDeviceView
    internal var repository: ConnectionDeviceRepository
    internal var executor: Executor
    private let SCAN_TIMEOUT = 5.0
    
    init(view: ConnectionDeviceView, repository: ConnectionDeviceRepository, executor: Executor) {
        self.view = view
        self.repository = repository
        self.executor = executor
    }
    
    func viewDidLoad() {
        repository.initialize()
    }
    
    func scan() {
        view.scanHasBeenLaunched()
        repository.getDevices(deviceFoundCallback: onNewDeviceFound)
        executor.runMainAfter(seconds: SCAN_TIMEOUT) { [weak self] in
            self?.repository.stopScan()
            self?.view.scanHasBeenStopped()
        }
    }
    
    private func onNewDeviceFound(newDevice: Device) {
        self.view.devicesFounded(with:
            DeviceViewModel(
                name: newDevice.name,
                address: "XX:XX:XX:XX:XX",
                deviceLogo: "icon_pairing_symbol_neutral",
                deviceTypeLogo: newDevice.typeToDeviceTypeLogo()
            )
        )
    }
    
    func didSelect(device: DeviceViewModel) {
        repository.connect(deviceId: device.name) // TODO PBA
    }
}
