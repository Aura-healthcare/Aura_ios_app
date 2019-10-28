import XCTest
@testable import Aura

class ConnectionDevicePresenterTests: XCTestCase {
    private var presenter: ConnectionDevicePresenter!
    private var view = MockConnectionDeviceView()
    private var repository = MockConnectionDeviceRepository()
    
    override func setUp() {
        super.setUp()
        presenter = ConnectionDevicePresenterImpl(iView: view, iRepository: repository)
    }
    
    func testScan(){
        // WHEN
        presenter.scan()
        // THEN
        XCTAssert(view.invokedScanHasBeenLaunchedCount == 1)
        XCTAssertTrue(view.invokedDevicesFounded)
        XCTAssertEqual(view.invokedDevicesFoundedData, [
            DeviceViewModel(name: "Polar H10 2E0E2A28",
                            address: "XX:XX:XX:XX:XX",
                            deviceLogo: "icon_pairing_symbol_neutral",
                            deviceTypeLogo: "hrv_connected"),
            DeviceViewModel(name: "MetaWear",
                            address: "XX:XX:XX:XX:XX",
                            deviceLogo: "icon_pairing_symbol_neutral",
                            deviceTypeLogo: "accelerometer_picture_disable"),
            DeviceViewModel(name: "MAXREFDES73#",
                            address: "XX:XX:XX:XX:XX",
                            deviceLogo: "icon_pairing_symbol_neutral",
                            deviceTypeLogo: "electro_dermal_activity_picture_disable")
            ])
        XCTAssert(view.invokedScanHasBeenStoppedCount == 1)
    }
    
    func testScan_whenEmpty(){
        // GIVEN
        presenter = ConnectionDevicePresenterImpl(iView: view, iRepository: MockConnectionDeviceEmptyRepository())
        // WHEN
        presenter.scan()
        // THEN
        XCTAssert(view.invokedScanHasBeenLaunchedCount == 1)
        XCTAssertFalse(view.invokedDevicesFounded)
        XCTAssert(view.invokedScanHasBeenStoppedCount == 1)
    }

}

class MockConnectionDeviceView: ConnectionDeviceView {
    var invokedScanHasBeenLaunchedCount = 0
    var invokedScanHasBeenStoppedCount = 0
    var invokedDevicesFounded = false
    var invokedDevicesFoundedData = [DeviceViewModel]()
    
    func scanHasBeenLaunched() {
        self.invokedScanHasBeenLaunchedCount += 1
    }
    
    func scanHasBeenStopped() {
        self.invokedScanHasBeenStoppedCount += 1
    }
    
    func devicesFounded(devices: [DeviceViewModel]) {
        self.invokedDevicesFounded = true
        self.invokedDevicesFoundedData = devices
    }
}

class MockConnectionDeviceEmptyRepository : ConnectionDeviceRepository {
    func getDevices() -> [Device] {
        return [Device]()
    }
}
