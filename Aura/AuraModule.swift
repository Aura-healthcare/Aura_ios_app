import UIKit

final class AuraModule {
    static var router: Router!
    
    static func signInViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: SignInViewController.self)) as! SignInViewController
        viewController.presenter = AuthenticationProviders.provideSignInPresenter(view: viewController)
        viewController.router = router
        return viewController
    }
    
    static func connectDeviceViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ConnectDeviceViewController.self)) as! ConnectDeviceViewController
        viewController.router = router
        return viewController
    }
    
    static func trackingViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: TrackingViewController.self)) as! TrackingViewController
        viewController.router = router
        return UINavigationController(rootViewController: viewController)
    }
    
    static func reportViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ReportViewController.self)) as! ReportViewController
        viewController.router = router
        return viewController
    }
    
    static func reportAdvancedViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ReportAdvancedViewController.self)) as! ReportAdvancedViewController
        return viewController
    }
}
