import UIKit

fileprivate class ValueTextField: UITextField {
    
    var property: InspectorProperty?
}

fileprivate class ValueSwitch: UISwitch {
    
    var property: InspectorProperty?
}

/// A View controlller for inspecting a view.
public class InspectorViewController: UITableViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
    /// The inspected view.
    public var inspectedView: UIView!
    
    /// Properties of the view.
    public var properties: [InspectorProperty] {
        return ((inspectedView as? Inspectable)?.properties ?? [])+[widthProperty(for: inspectedView), heightProperty(for: inspectedView), xProperty(for: inspectedView), yProperty(for: inspectedView)]
    }
    
    private var focusedTextField: UITextField?
    
    @objc private func switchValue(_ sender: ValueSwitch) {
        sender.property?.handler(InspectorProperty.Value(value: sender.isOn))
    }
    
    /// Initializes with given view.
    ///
    /// - Parameters:
    ///     - view: The inspected view.
    public init(view: UIView) {
        super.init(nibName: nil, bundle: nil)
        inspectedView = view
    }
    
    @objc private func close() {
        
        guard focusedTextField?.resignFirstResponder() == nil else {
            return
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func remove() {
        close()
        inspectedView.removeFromSuperview()
    }
    
    // MARK: - Table view controller
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSStringFromClass(type(of: inspectedView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(close))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(remove))
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let property = properties[indexPath.row]
        
        let label = UILabel(frame: cell.frame)
        label.frame.size.width = 100
        label.frame.origin.x = 20
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.text = property.name
                
        if property.valueType == .boolean {
            let valueSwitch = ValueSwitch()
            valueSwitch.property = property
            valueSwitch.frame.size.width = 49
            valueSwitch.frame.size.height = 31
            valueSwitch.frame.origin.y = 7
            valueSwitch.frame.origin.x = cell.frame.width-70
            valueSwitch.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
            valueSwitch.isOn = ((property.getValue().value as? Bool) == true)
            valueSwitch.addTarget(self, action: #selector(switchValue(_:)), for: .valueChanged)
            cell.contentView.addSubview(valueSwitch)
        } else {
            let valueTextField = ValueTextField()
            valueTextField.property = property
            valueTextField.delegate = self
            valueTextField.frame.size.width = 100
            valueTextField.frame.size.height = 30
            valueTextField.frame.origin.y = 7
            valueTextField.frame.origin.x = cell.frame.width-120
            valueTextField.autoresizingMask = [.flexibleWidth, .flexibleTopMargin, .flexibleBottomMargin]
            valueTextField.borderStyle = .roundedRect
            valueTextField.textAlignment = .right
            valueTextField.text = "\(property.getValue().value)"
            if property.valueType == .number || property.valueType == .integer {
                valueTextField.keyboardType = .numberPad
            }
            cell.contentView.addSubview(valueTextField)
        }
        
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Popover presentation controller delegate
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: - Text field delegate
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        guard let property = (textField as? ValueTextField)?.property else {
            return
        }
        
        let text = textField.text ?? ""
        
        focusedTextField = nil
        
        var value: Any?
        if property.valueType == .integer {
            value = Int(text)
        } else if property.valueType == .number, let double = Double(text) {
            value = CGFloat(double)
        } else if property.valueType == .string {
            value = text
        }
        if value == nil {
            let alert = UIAlertController(title: "Invalid value!", message: "The value you entered is invalid.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            textField.text = "\(property.getValue().value)"
        } else {
            property.handler(InspectorProperty.Value(value: value!))
            tableView.reloadData()
        }
        
        focusedTextField = nil
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        focusedTextField = textField
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        _ = textField.resignFirstResponder()
        return false
    }
}
