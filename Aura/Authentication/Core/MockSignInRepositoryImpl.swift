import Foundation

class MockSignInReposioryImpl : SignInRepository {
    func trySignIn(_ iUsername: String, _ iPassword: String, callback: (String?) -> ()) {
        if (iUsername == "octo" && iPassword == "octo"){
            callback(nil)
        } else {
            callback("Invalid username or password")
        }
    }
}
