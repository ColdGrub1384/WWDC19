import UIKit
import MobileCoreServices

/// A View controller for placing views.
public class LibraryViewController: UITableViewController, UITableViewDragDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        tableView.dragDelegate = self
        tableView.dragInteractionEnabled = true
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let item = Items[indexPath.row]
        
        let view: UIView
        if let backgroundColor = item.previewColor {
            view = UIView()
            view.frame.size.width = 55
            view.frame.size.height = 55
            view.backgroundColor = backgroundColor
            view.layer.borderColor = UIColor.gray.cgColor
            view.layer.borderWidth = 1
        } else {
            view = item.type.init()
        }
        
        view.frame.origin = cell.frame.origin
        view.isUserInteractionEnabled = false
        view.frame.size.width = 55
        view.frame.origin.x = 10
        view.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        cell.contentView.addSubview(view)
        
        item.preview(view: view)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.font = UIFont(name: "Menlo", size: UIFont.systemFontSize)
        label.textAlignment = .right
        label.text = NSStringFromClass(item.type)
        cell.accessoryView = label
        
        defer {
            view.center.y = cell.center.y
        }
        
        return cell
    }
    
    // MARK: - Table view drag delegate
    
    public func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let item = UIDragItem(itemProvider: NSItemProvider(item: indexPath.row as NSSecureCoding, typeIdentifier: kUTTypeItem as String))
        item.localObject = indexPath.row
        if let view = tableView.cellForRow(at: indexPath)?.contentView.subviews.first {
            item.previewProvider = {
                return UIDragPreview(view: view)
            }
        }
        return [item]
    }
}
