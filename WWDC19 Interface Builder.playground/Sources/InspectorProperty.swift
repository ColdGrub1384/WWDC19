import UIKit

/// A property of a view modifiable from the inspector.
public struct InspectorProperty {
    
    /// A value type.
    public enum ValueType {
        
        /// An integer number.
        case integer
        
        /// Any number.
        case number
        
        /// A string.
        case string
        
        /// A boolean.
        case boolean
    }
    
    /// A value.
    public struct Value {
        
        /// The raw value.
        public var value: Any
        
        /// Checks for type.
        ///
        /// - Returns: `true` if `value` conforms to `type`.
        public func `is`(_ type: ValueType) -> Bool {
            switch type {
            case .integer:
                return (value is Int)
            case .number:
                return (value is Int || value is Double || value is Float || value is CGFloat)
            case .string:
                return (value is String || value is NSString)
            case .boolean:
                return (value is Bool)
            }
        }
    }
    
    /// The name of the property.
    public var name: String
    
    /// The view containing this property.
    public var view: UIView
    
    /// The value type.
    public var valueType: ValueType
    
    /// Code called for getting current value.
    public var getValue: (() -> Value)
    
    /// The code called when the value is modified.
    public var handler: ((Value) -> Void)
}
