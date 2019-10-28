import Foundation

class Providers {
    static func provideSignInRepository() -> SignInRepository {
        #if DEBUG
            return MockSignInReposioryImpl()
        #else
            return nil
        #endif
        
    }
    
    static func provideConnectionDeviceRepository() -> ConnectionDeviceRepository {
        #if DEBUG
            return MockConnectionDeviceRepository()
        #else
            return nil
        #endif
        
    }
}
