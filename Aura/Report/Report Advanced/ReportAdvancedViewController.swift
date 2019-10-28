import Foundation
import UIKit
import Segmentio

class Question {
    var question : String
    var responses : [String]?
    var responsesIcon : [String]?
    var questionType : QuestionType
    
    init(question: String, responses : [String]?, responsesIcon : [String]?, questionType: QuestionType) {
        self.question = question
        self.responses = responses
        self.responsesIcon = responsesIcon
        self.questionType = questionType
    }
    
    enum QuestionType {
        case CHOICE
        case YESNO
        case COMMENT
    }
}

protocol FormResult {
    func onSucceed()
    func onExit()
}

class ReportAdvancedViewController : UIViewController, UITextViewDelegate {
    var questions : [Question]!
    var delegate: FormResult?
    
    @IBOutlet weak var segmentio : Segmentio!
    @IBOutlet weak var yesNoSegmentedControl : UISegmentedControl!
    @IBOutlet weak var questionLabel : UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        showNextQuestion()
    }
    
    private func showNextQuestion(){
        if let currentQuestion = questions.first {
            questionLabel.text = currentQuestion.question
            switch currentQuestion.questionType {
            case .CHOICE:
                yesNoSegmentedControl.isHidden = true
                segmentio.isHidden = false
                commentTextView.isHidden = true
                configureSegmentio(currentQuestion)
                break
            case .YESNO:
                yesNoSegmentedControl.isHidden = false
                segmentio.isHidden = true
                commentTextView.isHidden = true
                break
            case .COMMENT:
                yesNoSegmentedControl.isHidden = true
                segmentio.isHidden = true
                commentTextView.isHidden = false
                break
            }
            questions.removeFirst()
        }
    }
    
    private func configureSegmentio(_ currentQuestion : Question){
        var content = [SegmentioItem]()
        
        for i in 0..<currentQuestion.responses!.count {
            let item = SegmentioItem(
                title: currentQuestion.responses![i],
                image: UIImage(named: currentQuestion.responsesIcon![i])
            )
            content.append(item)
        }
        segmentio.setup(
            content: content,
            style: SegmentioStyle.imageOverLabel,
            options: SegmentioOptions(
                backgroundColor:  Color.background,
                segmentPosition: SegmentioPosition.fixed(maxVisibleItems: 3),
                scrollEnabled: true,
                indicatorOptions: SegmentioIndicatorOptions(
                    type: .bottom,
                    ratio: 1,
                    height: 5,
                    color: Color.mainColor
                ),
                horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions(
                    type: SegmentioHorizontalSeparatorType.none,
                    height: 1,
                    color: .gray
                ),
                verticalSeparatorOptions: SegmentioVerticalSeparatorOptions(
                    ratio: 0.4,
                    color: .gray
                ),
                imageContentMode: .center,
                labelTextAlignment: .center,
                segmentStates: SegmentioStates(
                    defaultState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: Color.mainTextColor
                    ),
                    selectedState: SegmentioState(
                        backgroundColor: .clear,
                        titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: Color.mainTextColor
                    ),
                    highlightedState: SegmentioState(
                        backgroundColor: UIColor.lightGray.withAlphaComponent(0.6),
                        titleFont: UIFont.boldSystemFont(ofSize: UIFont.smallSystemFontSize),
                        titleTextColor: Color.mainTextColor
                    )
                )
            )
        )
        segmentio.selectedSegmentioIndex = 0
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func nextAction(_ sender: Any){
        if (!questions.isEmpty){
            showNextQuestion()
        } else {
            delegate?.onSucceed()
            self.navigationController?.popViewController(animated: false)
        }
    }
    
}
