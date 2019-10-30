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
        XCTAssertTrue(repository.invokedStartScan)
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
        XCTAssertEqual(view.invokedDeviceConnected, "FakeDevice")
    }
}

class MockConnectionDeviceView: ConnectionDeviceView {
    var invokedScanHasBeenLaunchedCount = 0
    var invokedScanHasBeenStoppedCount = 0
    var invokedDeviceFounded = false
    var invokedDeviceFoundedData : DeviceViewModel? = nil
    var invokedDeviceConnected = ""
    
    func scanHasBeenLaunched() {
        invokedScanHasBeenLaunchedCount += 1
    }
    
    func scanHasBeenStopped() {
        invokedScanHasBeenStoppedCount += 1
    }
    
    func devicesFounded(with device: DeviceViewModel) {
        invokedDeviceFounded = true
        invokedDeviceFoundedData = device
    }
    
    func deviceConnected(named deviceName: String) {
        invokedDeviceConnected = deviceName
    }
}

class MockConnectionDeviceTestRepository : ConnectionDeviceRepository {
    var deviceFoundDelegate: ((Device) -> Void)?
    var connectDelegate: ((String) -> Void)?
    
    var invokedInitialize = false
    var invokedConnect = false
    var invokedStartScan = false
    var invokedStopScan = false
    
    func initialize() {
        invokedInitialize = true
    }
    
    func startScan() {
        invokedStartScan = true
        deviceFoundDelegate?(
            Device(name: "FakeDevice", type: .HEART)
        )
    }
    
    func connect(deviceName: String) {
        invokedConnect = true
        connectDelegate?("FakeDevice")
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
