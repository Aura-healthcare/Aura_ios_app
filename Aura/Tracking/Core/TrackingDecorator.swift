import Foundation

final class TrackingViewDecorator : TrackingView{
    private var view: TrackingView
    init(_ view: TrackingView) {
        self.view = view
    }
    
    func printNewLine(_ line: String) {
        DispatchQueue.main.async { [weak self] in self?.view.printNewLine(line) }
    }
}

final class TrackingPresenterDecorator : TrackingPresenter {
    private var presenter: TrackingPresenterImpl
    init(_ presenter: TrackingPresenterImpl) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.presenter.viewDidLoad()
        }
    }
}
