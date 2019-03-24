import UIKit

/// An `UIActivityIndicatorView`.
public struct ActivityIndicatorView: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UIActivityIndicatorView.self
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func preview(view: UIView) {
        let indicatorView = view as! UIActivityIndicatorView
        indicatorView.isHidden = false
        indicatorView.color = .gray
        indicatorView.frame.size.height = 20
    }
    
    public func configure(view: UIView) {
        let indicatorView = view as! UIActivityIndicatorView
        indicatorView.style = .gray
        indicatorView.frame.size.width = 20
        indicatorView.frame.size.height = 20
        indicatorView.startAnimating()
        indicatorView.autoresizingMask = [.flexibleRightMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleTopMargin]
    }
}
