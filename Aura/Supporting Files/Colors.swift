import UIKit

final class Color {
    static var mainColor: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor(named: "MainColor")!
            } else {
                return UIColor(red:0.117647, green:0.439216, blue:0.517647, alpha:1.0)
            }
        }
    }
    static var mainTextColor: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor.label
            } else {
                return UIColor.black
            }
        }
    }
    static var background: UIColor {
        get {
            if #available(iOS 13.0, *) {
                return UIColor.systemBackground
            } else {
                return UIColor.white
            }
        }
    }
}
