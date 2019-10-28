import Foundation
import UIKit

class TrackingViewController : BaseViewController {
    var router: Router!
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var horizontalStackView: UIStackView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func reportCrisis(_ sender: Any) {
        router.go(from: self, to: .report)
    }
}
