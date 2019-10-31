import XCTest
@testable import Aura

class TrackingPresenterImplTests: XCTestCase {
    private var presenter: TrackingPresenter!
    private var view = MockTrackingView()
    private var repository = MockTrackingTestRepository()
    
    override func setUp() {
        super.setUp()
        presenter = TrackingPresenterImpl(
            view: view,
            repository: repository
        )
    }
    
    func testViewDidLoad(){
        // WHEN
        presenter.viewDidLoad()
        
        // THEN
        XCTAssertTrue(repository.invokedExecuteStartSampling)
        XCTAssertEqual(view.invokedPrintNewLine, "This is a line")
    }
}

class MockTrackingView: TrackingView {
    var invokedPrintNewLine : String? = nil
    
    func printNewLine(_ line: String) {
        invokedPrintNewLine = line
    }
}

class MockTrackingTestRepository : TrackingRepository {
    var onReceiveDataDelegate : ((String) -> Void)?
    var invokedExecuteStartSampling = false
    func executeStartSampling() {
        invokedExecuteStartSampling = true
        onReceiveDataDelegate?("This is a line")
    }
}
