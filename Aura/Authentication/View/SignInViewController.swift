import Foundation
import UIKit
import Toast_Swift

class SignInViewController : BaseViewController, SignInView {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var presenter : SignInPresenter!
    var router : Router!
    
    func signInSucceed() {
        router.go(from: self, to: .connection)
    }
    
    func signInFail(with message: String) {
        view.makeToast(message, duration: 3.0, position: .top)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if let emailTypedByUser = emailTextField.text,
            let passwordTypedByUser = passwordTextField.text {
            presenter.signIn(
                email: emailTypedByUser,
                password: passwordTypedByUser
            )
        }
    }
}
