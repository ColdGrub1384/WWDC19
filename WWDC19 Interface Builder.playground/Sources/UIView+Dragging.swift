import UIKit
import MobileCoreServices

extension UIView: UIDragInteractionDelegate {
    
    public func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        guard InterfaceBuilderViewController.shared.editMode else {
            return []
        }
        
        let item = UIDragItem(itemProvider: NSItemProvider(item: tag as NSSecureCoding, typeIdentifier: kUTTypeItem as String))
        item.localObject = self
        return [item]
    }
}
