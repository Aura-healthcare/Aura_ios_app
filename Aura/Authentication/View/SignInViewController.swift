import Foundation
import UIKit
import Toast_Swift

class SignInViewController : BaseViewController, SignInView {
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    private var presenter : SignInPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SignInPresenterImpl(iView: self, iRepository: Providers.provideSignInRepository())
    }
    
    func signInSucceed() {
        present(Router.ConnectDeviceViewController(), animated: true, completion: nil)
    }
    
    func signInFails(_ iFailExtraMessage: String) {
        self.view.makeToast(iFailExtraMessage, duration: 3.0, position: .top)
        print(iFailExtraMessage)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        if let pseudo = pseudoTextField.text, let password = passwordTextField.text {
            presenter.signIn(iUsername: pseudo, iPassword: password)
        }
    }
}
