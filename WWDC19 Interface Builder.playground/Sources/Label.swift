import UIKit

/// An `UILabel`.
public struct Label: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UILabel.self
    }
    
    public func preview(view: UIView) {
        configure(view: view)
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        let label = view as! UILabel
        label.text = "Label"
        label.frame.size.height = 30
        label.frame.size.width = (view as! UILabel).systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
        label.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
}

extension UILabel: Inspectable {
    
    var properties: [InspectorProperty] {
        return [
            
            InspectorProperty(
                name: "Text",
                view: self,
                valueType: .string,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.text ?? "")
            }, handler: { (value) in
                if let text = value.value as? String {
                    self.text = text
                    self.frame.size.width = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
                }
            }),
        ]
    }
}
