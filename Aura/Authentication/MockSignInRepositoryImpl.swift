import Foundation

class MockSignInReposioryImpl : SignInRepository {
    func trySignIn(_ iUsername: String, _ iPassword: String, callback: (String?) -> ()) {
        if (iUsername == "TestWear1" && iPassword == "TestWear1"){
            callback(nil)
        } else {
            callback("Invalid username or password")
        }
    }
}
