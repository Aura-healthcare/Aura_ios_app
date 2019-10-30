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
            return MockConnectionDeviceRepositoryImpl()
        #else
            return ConnectionDeviceRepositoryImpl.sharedInstance
        #endif
        
    }
    
    static func provideTrackingRepository() -> TrackingRepository {
        #if DEBUG
            return MockConnectionDeviceRepositoryImpl()
        #else
            return ConnectionDeviceRepositoryImpl.sharedInstance
        #endif
        
    }
}
