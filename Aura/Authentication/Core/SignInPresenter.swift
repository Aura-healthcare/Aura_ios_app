import Foundation

// Protocol
protocol SignInPresenter {
    func signIn(iUsername : String, iPassword: String)
    func signInSucceed()
    func signInFails(iFailExtraMessage : String)
}

protocol SignInView : class {
    func signInSucceed()
    func signInFails(_ iFailExtraMessage: String)
}

protocol SignInRepository {
    func trySignIn(_ iUsername: String,_ iPassword: String, callback : @escaping (_ error: String?) -> ())
}

// Implementation
class SignInPresenterImpl : SignInPresenter {
    private weak var iView : SignInView?
    private let iRepository: SignInRepository
    
    init(
        iView : SignInView,
        iRepository: SignInRepository
        ) {
        self.iView = iView
        self.iRepository = iRepository
    }
    
    func signIn(iUsername: String, iPassword: String) {
        iRepository.trySignIn(iUsername, iPassword) { error in
            if let error = error {
                self.signInFails(iFailExtraMessage: error)
            } else {
                self.signInSucceed()
            }
        }
    }
    
    func signInSucceed() {
        iView?.signInSucceed()
    }
    
    func signInFails(iFailExtraMessage: String) {
        iView?.signInFails(iFailExtraMessage)
    }
}
