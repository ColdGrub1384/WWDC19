import UIKit

func widthProperty(for view: UIView) -> InspectorProperty {
    
    return InspectorProperty(
            name: "Width",
            view: view,
            valueType: .number,
            getValue: { () -> InspectorProperty.Value in
                return InspectorProperty.Value(value: view.frame.width)
            },
            handler: { (value) in
                
                let width: CGFloat
                if let integer = value.value as? Int {
                    width = CGFloat(integerLiteral: integer)
                } else if let double = value.value as? Double {
                    width = CGFloat(double)
                } else if let float = value.value as? Float {
                    width = CGFloat(float)
                } else {
                    width = value.value as? CGFloat ?? 0
                }
                
                view.frame.size.width = width
            })
}

func heightProperty(for view: UIView) -> InspectorProperty {
    
    return InspectorProperty(
        name: "Height",
        view: view,
        valueType: .number,
        getValue: { () -> InspectorProperty.Value in
            return InspectorProperty.Value(value: view.frame.height)
    },
        handler: { (value) in
            
            let height: CGFloat
            if let integer = value.value as? Int {
                height = CGFloat(integerLiteral: integer)
            } else if let double = value.value as? Double {
                height = CGFloat(double)
            } else if let float = value.value as? Float {
                height = CGFloat(float)
            } else {
                height = value.value as? CGFloat ?? 0
            }
            
            view.frame.size.height = height
    })
}

func xProperty(for view: UIView) -> InspectorProperty {
    
    return InspectorProperty(
        name: "X",
        view: view,
        valueType: .number,
        getValue: { () -> InspectorProperty.Value in
            return InspectorProperty.Value(value: view.frame.origin.x)
    },
        handler: { (value) in
            
            let x: CGFloat
            if let integer = value.value as? Int {
                x = CGFloat(integerLiteral: integer)
            } else if let double = value.value as? Double {
                x = CGFloat(double)
            } else if let float = value.value as? Float {
                x = CGFloat(float)
            } else {
                x = value.value as? CGFloat ?? 0
            }
            
            view.frame.origin.x = x
    })
}

func yProperty(for view: UIView) -> InspectorProperty {
    
    return InspectorProperty(
        name: "Y",
        view: view,
        valueType: .number,
        getValue: { () -> InspectorProperty.Value in
            return InspectorProperty.Value(value: view.frame.origin.y)
    },
        handler: { (value) in
            
            let y: CGFloat
            if let integer = value.value as? Int {
                y = CGFloat(integerLiteral: integer)
            } else if let double = value.value as? Double {
                y = CGFloat(double)
            } else if let float = value.value as? Float {
                y = CGFloat(float)
            } else {
                y = value.value as? CGFloat ?? 0
            }
            
            view.frame.origin.y = y
    })
}
