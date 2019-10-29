import Foundation

final class ConnectionDeviceViewDecorator : ConnectionDeviceView{
    private var iView: ConnectionDeviceView
    init(_ iView: ConnectionDeviceView) {
        self.iView = iView
    }
    
    func scanHasBeenStopped() {
        DispatchQueue.main.async { [weak self] in self?.iView.scanHasBeenStopped() }
    }
    
    func scanHasBeenLaunched() {
        DispatchQueue.main.async { [weak self] in self?.iView.scanHasBeenLaunched() }
    }
    
    func devicesFounded(with device: DeviceViewModel) {
        DispatchQueue.main.async { [weak self] in self?.iView.devicesFounded(with: device) }
    }
}

final class ConnectionDevicePresenterDecorator : ConnectionDevicePresenter {
    private var iPresenter: ConnectionDevicePresenterImpl
    init(_ iPresenter: ConnectionDevicePresenterImpl) {
        self.iPresenter = iPresenter
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.iPresenter.viewDidLoad()
        }
    }
    
    func scan() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.iPresenter.scan()
        }
    }
    
    func didSelect(device: DeviceViewModel) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.iPresenter.didSelect(device: device)
        }
    }
}

