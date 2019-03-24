import UIKit

/// An `UIButton`
public struct Button: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UIButton.self
    }
    
    public func preview(view: UIView) {
        configure(view: view)
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        let button = view as! UIButton
        button.frame.size.width = 60
        button.frame.size.height = 30
        button.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Button", for: .normal)
        button.setTitleColor(view.tintColor, for: .normal)
    }
}

/// An `UIButton` with solid background color and rounded corners.
public struct RoundedRectButton: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UIButton.self
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func preview(view: UIView) {
        let button = view as! UIButton
        button.frame.size.width = 120
        button.frame.size.height = 50
        button.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = view.tintColor
        button.layer.cornerRadius = 6
    }
    
    public func configure(view: UIView) {
        let button = view as! UIButton
        button.frame.size.width = 120
        button.frame.size.height = 50
        button.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = view.tintColor
        button.layer.cornerRadius = 12
    }
}

extension UIButton: Inspectable {
    
    var properties: [InspectorProperty] {
        return [
            
            InspectorProperty(
                name: "Title",
                view: self,
                valueType: .string,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.title(for: .normal) ?? "")
            }, handler: { (value) in
                if let text = value.value as? String {
                    self.setTitle(text, for: .normal)
                    self.frame.size.width = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width+10
                }
            }),
        ]
    }
}
