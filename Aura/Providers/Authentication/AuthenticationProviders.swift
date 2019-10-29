class AuthenticationProviders {
    static func provideSignInPresenter(view: SignInView) -> SignInPresenter {
        return SignInPresenterImpl(iView: view, iRepository: RepositoryProviders.provideSignInRepository())
    }
}
