import UIKit

/// An `UISwitch`.
public struct Switch: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UISwitch.self
    }
    
    public func preview(view: UIView) {}
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        view.frame.size.width = 49
        view.frame.size.height = 31
        view.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleTopMargin]
    }
}

extension UISwitch: Inspectable {
    
    var properties: [InspectorProperty] {
        return [
            InspectorProperty(
                name: "Is On",
                view: self,
                valueType: .boolean,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.isOn)
                }, handler: { (value) in
                    self.isOn = ((value.value as? Bool) == true)
                })
        ]
    }
}
