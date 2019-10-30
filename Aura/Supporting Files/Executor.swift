import Foundation

class Executor {
    
    func runMainAfter(seconds : Double, callback: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            callback()
        }
    }
}
