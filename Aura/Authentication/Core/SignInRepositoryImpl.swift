import Firebase

final class SignInRepositoryImpl : SignInRepository {
    func trySignIn(_ email: String, _ password: String, callback: @escaping (String?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let error = error else {
                callback(nil)
                return
            }
            callback(error.localizedDescription)
        }
    }
}
