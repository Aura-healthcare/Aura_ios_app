import Foundation

// Protocol
protocol TrackingPresenter {
    func viewDidLoad()
}

protocol TrackingRepository {
    var onReceiveDataDelegate : ((String) -> Void)? { get set }
    func executeStartSampling()
}

protocol TrackingView {
    func printNewLine(_ line: String)
}

// Implementation
class TrackingPresenterImpl : TrackingPresenter {
    private var decorator : TrackingView
    private var repository : TrackingRepository
    
    init(view: TrackingView, repository: TrackingRepository) {
        self.decorator = view
        self.repository = repository
    }
    
    func viewDidLoad() {
        repository.onReceiveDataDelegate = { [weak self] line in
            self?.decorator.printNewLine(line)
        }
        repository.executeStartSampling()
    }
}
