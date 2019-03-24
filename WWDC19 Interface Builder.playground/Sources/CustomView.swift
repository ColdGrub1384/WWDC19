import UIKit

/// A type for implementing a custom view placable from the library. Instances can be added to `Items` global variable.
public struct CustomView: InterfaceBuilderView {
    
    private var _type: UIView.Type
    private var _previewHandler: ((UIView) -> Void)?
    private var _configurationHandler: ((UIView) -> Void)?
    private var _previewColor: UIColor?
    
    /// Initializes a custom view.
    ///
    /// - Parameters:
    ///     - type: The type of view.
    ///     - previewHandler: Code called for configuring the preview.
    ///     - configurationHandler: Code called for configuring the view when it's placed.
    public init(type: UIView.Type, previewHandler: ((UIView) -> Void)?, configurationHandler: ((UIView) -> Void)?) {
        
        _type = type
        _previewHandler = previewHandler
        _configurationHandler = configurationHandler
    }
    
    /// Initializes a custom view.
    ///
    /// - Parameters:
    ///     - type: The type of view.
    ///     - previewColor: Color of the preview.
    ///     - configurationHandler: Code called for configuring the view when it's placed.
    public init(type: UIView.Type, previewColor: UIColor?, configurationHandler: ((UIView) -> Void)?) {
        
        _type = type
        _previewColor = previewColor
        _configurationHandler = configurationHandler
    }
    
    // MARK: Interface builder view
    
    public var type: UIView.Type {
        return _type
    }
    
    public var previewColor: UIColor? {
        return _previewColor
    }
    
    public func configure(view: UIView) {
        _configurationHandler?(view)
    }
    
    public func preview(view: UIView) {
        _previewHandler?(view)
    }
}
