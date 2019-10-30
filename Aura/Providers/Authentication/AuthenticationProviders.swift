class AuthenticationProviders {
    static func provideSignInPresenter(view: SignInView) -> SignInPresenter {
        return SignInPresenterImpl(
            view: view,
            repository: RepositoryProviders.provideSignInRepository()
        )
    }
}
