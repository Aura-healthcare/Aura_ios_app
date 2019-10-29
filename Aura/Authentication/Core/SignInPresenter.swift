import Foundation

// Protocol
protocol SignInPresenter {
    func signIn(email : String, password: String)
    func signInSucceed()
    func signInFail(with message: String)
}

protocol SignInView : class {
    func signInSucceed()
    func signInFail(with message: String)
}

protocol SignInRepository {
    func trySignIn(_ email: String,_ password: String, callback : @escaping (_ error: String?) -> ())
}

// Implementation
class SignInPresenterImpl : SignInPresenter {
    private weak var view : SignInView?
    private let repository: SignInRepository
    
    init(
        view : SignInView,
        repository: SignInRepository
    ) {
        self.view = view
        self.repository = repository
    }
    
    func signIn(email: String, password: String) {
        repository.trySignIn(email, password) { error in
            if let error = error {
                self.signInFail(with: error)
            } else {
                self.signInSucceed()
            }
        }
    }
    
    func signInSucceed() {
        view?.signInSucceed()
    }
    
    func signInFail(with message: String) {
        view?.signInFail(with: message)
    }
}
