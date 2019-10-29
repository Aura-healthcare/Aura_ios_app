import XCTest
@testable import Aura

class SignInPresenterTests: XCTestCase {
    
    private var presenter : SignInPresenter!
    private let view = MockSignInView()
    let repository = MockSignInSucceedRepository()
    
    override func setUp() {
        super.setUp()
        presenter = SignInPresenterImpl(view: view, repository: repository)
    }
    
    func testSignIn_Succeed() {
        // GIVEN
        let view = MockSignInView()
        let repository = MockSignInSucceedRepository()
        presenter = SignInPresenterImpl(view: view, repository: repository)
        
        // WHEN
        presenter.signIn(email: "email", password: "password")
        
        // THEN
        XCTAssertTrue(repository.invokedTrySignIn)
        XCTAssert(repository.invokedTrySignInParams1 == "email")
        XCTAssert(repository.invokedTrySignInParams2 == "password")
        XCTAssert(repository.invokedTrySignInError == nil)
    }
    
    func testSignIn_Error() {
        // GIVEN
        let view = MockSignInView()
        let repository = MockSignInErrorRepository()
        presenter = SignInPresenterImpl(view: view, repository: repository)
        
        // WHEN
        presenter.signIn(email: "email", password : "password")
        
        // THEN
        XCTAssertTrue(repository.invokedTrySignIn)
        XCTAssert(repository.invokedTrySignInParams1 == "email")
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
        presenter.signInFail(with: "error")
        // THEN
        XCTAssert(view.invokedSignInFailsCount == 1)
    }

    
}
