import Foundation

class ConnectionDeviceViewDecorator : ConnectionDeviceView{
    private var iView: ConnectionDeviceView
    init(_ iView: ConnectionDeviceView) {
        self.iView = iView
    }
    
    func scanHasBeenStopped() {
        DispatchQueue.main.async { self.iView.scanHasBeenStopped() }
    }
    
    func scanHasBeenLaunched() {
        DispatchQueue.main.async { self.iView.scanHasBeenLaunched() }
    }
    
    func devicesFounded(devices: [DeviceViewModel]) {
        DispatchQueue.main.async { self.iView.devicesFounded(devices: devices) }
    }
}

class ConnectionDevicePresenterDecorator : ConnectionDevicePresenter {
    private var iPresenter: ConnectionDevicePresenterImpl
    init(_ iPresenter: ConnectionDevicePresenterImpl) {
        self.iPresenter = iPresenter
    }
    
    func scan() {
        DispatchQueue.global(qos: .background).async {
            self.iPresenter.scan()
        }
    }
}

