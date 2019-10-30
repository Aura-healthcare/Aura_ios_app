import XCTest
@testable import Aura

class ConnectionDevicePresenterTests: XCTestCase {
    private var presenter: ConnectionDevicePresenter!
    private var view = MockConnectionDeviceView()
    private var repository = MockConnectionDeviceTestRepository()
    
    override func setUp() {
        super.setUp()
        presenter = ConnectionDevicePresenterImpl(
            view: view,
            repository: repository,
            executor: MockExecutor()
        )
    }
    
    func testViewDidLoad(){
        // WHEN
        presenter.viewDidLoad()
        
        // THEN
        XCTAssertTrue(repository.invokedInitialize)
    }
    
    func testScan(){
        // WHEN
        presenter.scan()
        
        // THEN
        XCTAssert(view.invokedScanHasBeenLaunchedCount == 1)
        XCTAssertTrue(view.invokedDeviceFounded)
        XCTAssertEqual(view.invokedDeviceFoundedData,
                       DeviceViewModel(
                        name: "FakeDevice",
                        address: "XX:XX:XX:XX:XX",
                        deviceLogo: "icon_pairing_symbol_neutral",
                        deviceTypeLogo: "hrv_connected")
        )
        XCTAssertTrue(repository.invokedStopScan)
        XCTAssert(view.invokedScanHasBeenStoppedCount == 1)
    }
    
    func testDidSelect() {
        // WHEN
        presenter.didSelect(device:
            DeviceViewModel(
                name: "FakeDevice",
                address: "XXXX:XXXX:XXXX",
                deviceLogo: "logo",
                deviceTypeLogo: "typeLogo"
            )
        )
        
        // THEN
        XCTAssertTrue(repository.invokedConnect)
    }
}

class MockConnectionDeviceView: ConnectionDeviceView {
    var invokedScanHasBeenLaunchedCount = 0
    var invokedScanHasBeenStoppedCount = 0
    var invokedDeviceFounded = false
    var invokedDeviceFoundedData : DeviceViewModel? = nil
    
    func scanHasBeenLaunched() {
        self.invokedScanHasBeenLaunchedCount += 1
    }
    
    func scanHasBeenStopped() {
        self.invokedScanHasBeenStoppedCount += 1
    }
    
    func devicesFounded(with device: DeviceViewModel) {
        self.invokedDeviceFounded = true
        self.invokedDeviceFoundedData = device
    }
}

class MockConnectionDeviceTestRepository : ConnectionDeviceRepository {
    
    var invokedInitialize = false
    var invokedConnect = false
    var invokedStopScan = false
    
    func initialize() {
        invokedInitialize = true
    }
    
    func getDevices(deviceFoundCallback: @escaping (Device) -> Void) {
        deviceFoundCallback(
            Device(name: "FakeDevice", type: .HEART)
        )
    }
    
    func connect(deviceId: String) {
        invokedConnect = true
    }
    
    func stopScan() {
        invokedStopScan = true
    }
}

class MockExecutor : Executor {
    override func runMainAfter(seconds: Double, callback: @escaping () -> ()) {
        callback()
    }
}
