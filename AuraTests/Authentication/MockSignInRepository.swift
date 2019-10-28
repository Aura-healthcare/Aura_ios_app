import Foundation
@testable import Aura

class MockSignInErrorRepository : SignInRepository {
    var invokedTrySignIn = false
    var invokedTrySignInParams1 = ""
    var invokedTrySignInParams2 = ""
    var invokedTrySignInError : String?
    
    func trySignIn(_ iUsername: String, _ iPassword: String, callback: (String?) -> ()) {
        invokedTrySignIn = true
        invokedTrySignInParams1 = iUsername
        invokedTrySignInParams2 = iPassword
        invokedTrySignInError = "error"
        callback("error")
    }
}

class MockSignInSucceedRepository : SignInRepository {
    var invokedTrySignIn = false
    var invokedTrySignInParams1 = ""
    var invokedTrySignInParams2 = ""
    var invokedTrySignInError : String?
    
    func trySignIn(_ iUsername: String, _ iPassword: String, callback: (String?) -> ()) {
        invokedTrySignIn = true
        invokedTrySignInParams1 = iUsername
        invokedTrySignInParams2 = iPassword
        invokedTrySignInError = nil
        callback(nil)
    }
}
