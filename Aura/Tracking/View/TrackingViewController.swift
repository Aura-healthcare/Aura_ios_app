import Foundation
import UIKit

class TrackingViewController : BaseViewController, TrackingView {
    var router: Router!
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    var presenter : TrackingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "\n\n"
        presenter.viewDidLoad()
    }
    
    @IBAction func reportCrisis(_ sender: Any) {
        router.go(from: self, to: .report)
    }
    
    func printNewLine(_ line: String) {
        let newText = textView.text + "\n\(line)"
        textView.text = newText
        let bottom = NSMakeRange(textView.text.count - 1, 1)
        textView.scrollRangeToVisible(bottom)
    }
}
