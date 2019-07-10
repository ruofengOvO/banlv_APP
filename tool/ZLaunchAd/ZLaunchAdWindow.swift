
import UIKit

extension UIWindow {
    open override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        for sub_view in subviews {
            if sub_view.isKind(of: ZLaunchAdView.self) {
                bringSubviewToFront(sub_view)
            }
        }
    }
}
