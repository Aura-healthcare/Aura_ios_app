import Firebase

final class SignInRepositoryImpl : SignInRepository {
    func trySignIn(_ iUsername: String, _ iPassword: String, callback: @escaping (String?) -> ()) {
        Auth.auth().signIn(withEmail: iUsername, password: iPassword) { (result, error) in
            guard let error = error else {
                callback(nil)
                return
            }
            callback(error.localizedDescription)
        }
    }
}
