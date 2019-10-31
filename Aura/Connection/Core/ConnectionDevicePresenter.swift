import Foundation

// Protocol
protocol ConnectionDevicePresenter {
    func viewDidLoad()
    func scan()
    func didSelect(device: DeviceViewModel)
}

protocol ConnectionDeviceView : class {
    func scanHasBeenLaunched()
    func scanHasBeenStopped()
    func devicesFounded(with device : DeviceViewModel)
    func deviceConnected(named deviceName: String)
}

protocol ConnectionDeviceRepository {
    var deviceFoundDelegate: ((Device) -> Void)? { get set }
    var connectDelegate: ((String) -> Void)? { get set }
    func initialize()
    func startScan()
    func connect(deviceName: String)
    func stopScan()
}

// Implementation
class ConnectionDevicePresenterImpl : ConnectionDevicePresenter {
    private var decorator: ConnectionDeviceView
    private var repository: ConnectionDeviceRepository
    private var executor: Executor
    private let SCAN_TIMEOUT = 5.0
    
    init(view: ConnectionDeviceView, repository: ConnectionDeviceRepository, executor: Executor) {
        self.decorator = view
        self.repository = repository
        self.executor = executor
    }
    
    func viewDidLoad() {
        repository.initialize()
    }
    
    func scan() {
        decorator.scanHasBeenLaunched()
        repository.deviceFoundDelegate = { [weak self] newDevice in
            self?.decorator.devicesFounded(with:
                DeviceViewModel(
                    name: newDevice.name,
                    address: "XX:XX:XX:XX:XX",
                    deviceLogo: "icon_pairing_symbol_neutral",
                    deviceTypeLogo: newDevice.typeToDeviceTypeLogo()
                )
            )
        }
        repository.startScan()
        executor.runMainAfter(seconds: SCAN_TIMEOUT) { [weak self] in
            self?.repository.stopScan()
            self?.decorator.scanHasBeenStopped()
        }
    }
    
    func didSelect(device: DeviceViewModel) {
        repository.connectDelegate = { [weak self] deviceName in
            self?.decorator.deviceConnected(named: deviceName)
        }
        repository.connect(deviceName: device.name)
    }
}
