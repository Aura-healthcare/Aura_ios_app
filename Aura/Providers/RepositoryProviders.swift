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
            return MockConnectionDeviceRepository()
        #else
            return MockConnectionDeviceRepository()
        #endif
        
    }
}