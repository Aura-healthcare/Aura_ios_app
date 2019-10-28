import Foundation
import UIKit

class Router {
    private static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    static func ConnectDeviceViewController() -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "ConnectDeviceViewController")
    }
    
    static func ReportViewController() -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "ReportViewController")
    }
    
    static func TrackingViewController() -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "TrackingViewController")
    }
    
    static func ReportAdvancedViewController() -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: "ReportAdvancedViewController")
    }
}
