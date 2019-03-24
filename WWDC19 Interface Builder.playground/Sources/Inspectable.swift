import Foundation

/// A protocol for implementing modifiable properties of a view.
///
/// # Usage
/// Extend an `UIView` subclass by conforming to this protocol. Properties added will be modifiable from the inspector.
protocol Inspectable {
    
    /// Modifiable properties.
    var properties: [InspectorProperty] { get }
}
