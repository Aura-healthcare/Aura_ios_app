import UIKit
import Firebase
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let syncIdentifier = "com.wearablesensor.aura.Aura.sync"
    private let timeBeforeResync: TimeInterval = 6 * 60 * 60
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if NSClassFromString("XCTestCase") != nil {
            return true
        }
        
        let router = AppRouter()
        AuraModule.router = router
        window = UIWindow()
        window?.rootViewController = router.rootViewController()
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        registerTasks()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        BGTaskScheduler.shared.cancelAllTaskRequests()
        scheduleSyncWithDevice()
    }
}

//MARK: Register Background Tasks
extension AppDelegate {
    private func registerTasks() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: syncIdentifier, using: nil) { task in
            self.handleSyncWithDeviceTask(task: task as! BGAppRefreshTask)
        }
    }
    
    private func cancelAllPandingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    private func scheduleSyncWithDevice() {
        let request = BGAppRefreshTaskRequest(identifier: syncIdentifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: timeBeforeResync)
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    private func handleSyncWithDeviceTask(task: BGAppRefreshTask) {
        //TODO PBA - TODO WORK - Connect to device and get data to store
        scheduleSyncWithDevice()
        task.expirationHandler = {
            // Cancel works if needed
        }
        task.setTaskCompleted(success: true)
    }
}

