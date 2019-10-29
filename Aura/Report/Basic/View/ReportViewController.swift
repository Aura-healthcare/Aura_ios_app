import Foundation
import UIKit

class ReportViewController : BaseViewController, FormResult {
    var router : Router!
    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func confirmAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreInformationAction(_ sender: Any) {
        router.go(
            from: self,
            to:  .reportAdvanced(
                delegate: self,
                questions: [
                Question(
                    question: Message.TREATMENT_FOLLOWED.localized,
                    responses: [
                        Message.Q1_A1.localized,
                        Message.Q1_A2.localized,
                        Message.Q1_A3.localized
                    ],
                    responsesIcon: [
                        "treatment_ok_64",
                        "treatment_low_64",
                        "treatment_none_64"
                    ],
                    questionType: .CHOICE
                ),
                Question(
                    question: Message.WELL_SLEEPED.localized,
                    responses: [
                        Message.Q2_A1.localized,
                        Message.Q2_A2.localized,
                        Message.Q2_A3.localized
                    ],
                    responsesIcon: [
                        "sleep_well_64",
                        "wake_up_64",
                        "insomnia_64"
                    ],
                    questionType: .CHOICE
                ),
                Question(
                    question: Message.STRESSED_TODAY.localized,
                    responses: nil, responsesIcon: nil,
                    questionType: .YESNO
                ),
                Question(
                    question: Message.FEVER_TODAY.localized,
                    responses: nil, responsesIcon: nil,
                    questionType: .YESNO
                ),
                Question(
                    question: Message.ALCOHOL_YESTERDAY.localized,
                    responses: [
                        Message.Q3_A1.localized,
                        Message.Q3_A2.localized,
                        Message.Q3_A3.localized
                    ],
                    responsesIcon: [
                        "no_drink_64",
                        "drink_64",
                        "drink_high_64"
                    ],
                    questionType: .CHOICE
                ),
                Question(
                    question: Message.TREATMENT_CHANGED.localized,
                    responses: nil, responsesIcon: nil,
                    questionType: .YESNO
                ),
                Question(
                    question: Message.PARTY_LAST_NIGHT.localized,
                    responses: nil, responsesIcon: nil,
                    questionType: .YESNO
                ),
                Question(
                    question: Message.COMMENT.localized,
                    responses: nil, responsesIcon: nil,
                    questionType: .COMMENT
                )
            ])
        )
    }
    
    func onExit() {
        print("User exit the form")
    }
    
    func onSucceed() {
        self.view.makeToast(Message.THANKS.localized, duration: 3.0, position: .bottom)
    }
}
