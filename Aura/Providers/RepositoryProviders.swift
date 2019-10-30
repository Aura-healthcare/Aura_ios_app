import Foundation

class RepositoryProviders {
    static func provideSignInRepository() -> SignInRepository {
        #if DEBUG
            return MockSignInReposioryImpl()
        #else
            return SignInRepositoryImpl()
        #endif
        
    }
    
    static func provideConnectionDeviceRepository() -> ConnectionDeviceRepository {
        #if DEBUG
            return ConnectionDeviceRepositoryImpl.sharedInstance // TODO PBA
        #else
            return ConnectionDeviceRepositoryImpl.sharedInstance
        #endif
        
    }
}
