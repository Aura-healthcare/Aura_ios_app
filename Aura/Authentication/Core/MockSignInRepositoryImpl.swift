import Foundation

class MockSignInReposioryImpl : SignInRepository {
    func trySignIn(_ email: String, _ password: String, callback: (String?) -> ()) {
        if (email == "octo" && password == "octo") {
            callback(nil)
        } else {
            callback("Invalid username or password")
        }
    }
}
