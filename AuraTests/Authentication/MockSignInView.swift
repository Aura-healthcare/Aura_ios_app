import Foundation
@testable import Aura

class MockSignInView : SignInView {
    var invokedSignInSucceedCount = 0
    var invokedSignInFailsCount = 0
    
    func signInSucceed() {
        invokedSignInSucceedCount += 1
    }
    
    func signInFails(_ iFailExtraMessage: String) {
        invokedSignInFailsCount += 1
    }
}
