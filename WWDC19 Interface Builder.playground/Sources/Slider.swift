import UIKit

/// An `UISlider`.
public struct Slider: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UISlider.self
    }
    
    public func preview(view: UIView) {
        (view as! UISlider).value = 1
    }
    
    public var previewColor: UIColor? {
        return nil
    }
    
    public func configure(view: UIView) {
        let slider = view as! UISlider
        slider.value = 0.5
        slider.frame.size.width = 118
        slider.frame.size.height = 30
        slider.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleTopMargin, .flexibleWidth]
    }
}

extension UISlider: Inspectable {
    
    var properties: [InspectorProperty] {
        return [
            InspectorProperty(
                name: "Value",
                view: self, valueType: .number,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.value)
                }, handler: { (propertyValue) in
                    let value: Float
                    if let integer = propertyValue.value as? Int {
                        value = Float(exactly: integer) ?? 0
                    } else if let double = propertyValue.value as? Double {
                        value = Float(exactly: double) ?? 0
                    } else if let cgFloat = propertyValue.value as? CGFloat {
                        value = Float(cgFloat)
                    } else {
                        value = propertyValue.value as? Float ?? 0
                    }
                    self.value = value
                })
        ]
    }
}
