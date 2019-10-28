import Foundation
import UIKit
import Toast_Swift

class SignInViewController : BaseViewController, SignInView {
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var presenter : SignInPresenter!
    var router : Router!
    
    func signInSucceed() {
        router.go(from: self, to: .connection)
    }
    
    func signInFails(_ iFailExtraMessage: String) {
        view.makeToast(iFailExtraMessage, duration: 3.0, position: .top)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if let pseudo = pseudoTextField.text, let password = passwordTextField.text {
            presenter.signIn(iUsername: pseudo, iPassword: password)
        }
    }
}
