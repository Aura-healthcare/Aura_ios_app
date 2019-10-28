import XCTest
@testable import Aura

class SignInPresenterTests: XCTestCase {
    
    private var presenter : SignInPresenter!
    private let view = MockSignInView()
    let repository = MockSignInSucceedRepository()
    
    override func setUp() {
        super.setUp()
        presenter = SignInPresenterImpl(iView: view, iRepository: repository)
    }
    
    func testSignIn_Succeed() {
        // GIVEN
        let view = MockSignInView()
        let repository = MockSignInSucceedRepository()
        presenter = SignInPresenterImpl(iView: view, iRepository: repository)
        
        // WHEN
        presenter.signIn(iUsername: "username", iPassword: "password")
        
        // THEN
        XCTAssertTrue(repository.invokedTrySignIn)
        XCTAssert(repository.invokedTrySignInParams1 == "username")
        XCTAssert(repository.invokedTrySignInParams2 == "password")
        XCTAssert(repository.invokedTrySignInError == nil)
    }
    
    func testSignIn_Error() {
        // GIVEN
        let view = MockSignInView()
        let repository = MockSignInErrorRepository()
        presenter = SignInPresenterImpl(iView: view, iRepository: repository)
        
        // WHEN
        presenter.signIn(iUsername: "username", iPassword: "password")
        
        // THEN
        XCTAssertTrue(repository.invokedTrySignIn)
        XCTAssert(repository.invokedTrySignInParams1 == "username")
        XCTAssert(repository.invokedTrySignInParams2 == "password")
        XCTAssert(repository.invokedTrySignInError == "error")
    }
    
    func testSignInSucceed() {
        // WHEN
        presenter.signInSucceed()
        // THEN
        XCTAssert(view.invokedSignInSucceedCount == 1)
    }
    
    func testSignInFails() {
        // WHEN
        presenter.signInFails(iFailExtraMessage: "error")
        // THEN
        XCTAssert(view.invokedSignInFailsCount == 1)
    }

    
}
