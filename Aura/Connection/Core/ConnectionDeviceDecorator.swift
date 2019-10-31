import Foundation

final class ConnectionDeviceViewDecorator : ConnectionDeviceView{
    private var view: ConnectionDeviceView
    init(_ view: ConnectionDeviceView) {
        self.view = view
    }
    
    func scanHasBeenStopped() {
        DispatchQueue.main.async { self.view.scanHasBeenStopped() }
    }
    
    func scanHasBeenLaunched() {
        DispatchQueue.main.async { self.view.scanHasBeenLaunched() }
    }
    
    func devicesFounded(with device: DeviceViewModel) {
        DispatchQueue.main.async { self.view.devicesFounded(with: device) }
    }
    
    func deviceConnected(named deviceName: String) {
        DispatchQueue.main.async { self.view.deviceConnected(named: deviceName) }
    }
}

final class ConnectionDevicePresenterDecorator : ConnectionDevicePresenter {
    private var presenter: ConnectionDevicePresenterImpl
    init(_ presenter: ConnectionDevicePresenterImpl) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async {
            self.presenter.viewDidLoad()
        }
    }
    
    func scan() {
        DispatchQueue.global(qos: .background).async {
            self.presenter.scan()
        }
    }
    
    func didSelect(device: DeviceViewModel) {
        DispatchQueue.global(qos: .background).async {
            self.presenter.didSelect(device: device)
        }
    }
}

