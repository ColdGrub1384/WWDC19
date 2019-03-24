import UIKit

/// An `UINavigationBar`.
public struct NavigationBar: InterfaceBuilderView {
    
    public init() {}
    
    public var type: UIView.Type {
        return UINavigationBar.self
    }
    
    public var previewColor: UIColor? {
        return UIColor(displayP3Red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
    }
    
    public func preview(view: UIView) {}
    
    public func configure(view: UIView) {
        let navigationBar = view as! UINavigationBar
        navigationBar.frame.origin.x = 0
        navigationBar.frame.origin.y = 0
        navigationBar.frame.size.width = view.superview?.frame.width ?? 375
        navigationBar.frame.size.height = 44
        navigationBar.autoresizingMask = [.flexibleBottomMargin, .flexibleWidth]
        navigationBar.items = [UINavigationItem(title: "Title")]
    }
}

extension UINavigationBar: Inspectable {
    
    var properties: [InspectorProperty] {
        return [
            
            InspectorProperty(
                name: "Title",
                view: self,
                valueType: .string,
                getValue: { () -> InspectorProperty.Value in
                    return InspectorProperty.Value(value: self.topItem?.title ?? "")
                }, handler: { (value) in
                    if let title = value.value as? String {
                        self.topItem?.title = title
                    }
                }),
        ]
    }
}
