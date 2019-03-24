import UIKit

/// An `UITextField`.
public struct TextField: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UITextField.self
    }
    
    public func preview(view: UIView) {
        let textField = view as! UITextField
        textField.text = "Text"
        textField.frame.size.height = 30
        textField.borderStyle = .roundedRect
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        let textField = view as! UITextField
        textField.frame.size.height = 30
        textField.frame.size.width = 200
        textField.borderStyle = .roundedRect
        textField.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleTopMargin]
    }
}

extension UITextField: Inspectable {
    
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
                }
            }),
            
            InspectorProperty(
                name: "Placeholder",
                view: self,
                valueType: .string,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.placeholder ?? "")
            }, handler: { (value) in
                if let text = value.value as? String {
                    self.placeholder = text
                }
            }),
        ]
    }
}
