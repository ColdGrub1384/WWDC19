import UIKit

/// An `UIStepper`.
public struct Stepper: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UIStepper.self
    }
    
    public func preview(view: UIView) {}
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        view.frame.size.width = 94
        view.frame.size.height = 29
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleTopMargin]
    }
}
