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
        let presenter = ConnectionDevicePresenterImpl(
            view: ConnectionDeviceViewDecorator(viewController),
            repository: RepositoryProviders.provideConnectionDeviceRepository()
        )
        viewController.presenter = ConnectionDevicePresenterDecorator(presenter)
        viewController.router = router
        return viewController
    }
    
    static func trackingViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: TrackingViewController.self)) as! TrackingViewController
        viewController.router = router
        
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = textAttributes
        navigationController.navigationBar.topItem?.title = Message.TRACK.localized
        
        return navigationController
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
