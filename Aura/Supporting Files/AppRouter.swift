import UIKit

final class AppRouter : Router {
    
    func rootViewController() -> UIViewController {
        return AuraModule.signInViewController()
    }
    
    func go(from vc: UIViewController, to link: Link) {
        switch link {
        case .signIn: vc.present(AuraModule.signInViewController(), animated: true, completion: nil)
        case .connection: vc.present(AuraModule.connectDeviceViewController(), animated: true, completion: nil)
        case .tracking: vc.present(AuraModule.trackingViewController(), animated: true, completion: nil)
        case .report: vc.navigationController?.pushViewController(AuraModule.reportViewController(), animated: true)
        case .reportAdvanced(let delegate, let questions):
            let viewController = AuraModule.reportAdvancedViewController() as! ReportAdvancedViewController
            viewController.delegate = delegate
            viewController.questions = questions
            vc.navigationController?.pushViewController(
                viewController,
                animated: true
            )
            break
        }
    }
}

protocol Router{
    func go(from vc: UIViewController, to link: Link)
}

enum Link {
    case signIn
    case connection
    case tracking
    case report
    case reportAdvanced(delegate: FormResult?, questions: [Question])
}
