import UIKit

/// The View controller containing placed views.
public class InterfaceBuilderViewController: UIViewController, UIDropInteractionDelegate {
    
    /// The shared instance.
    public static let shared = InterfaceBuilderViewController()
    
    /// The button for entering edit mode.
    public lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
    }()
    
    /// The button for showing library.
    public lazy var libraryButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 4
        button.alpha = 0
        button.addTarget(self, action: #selector(showLibrary), for: .touchUpInside)
        return button
    }()
    
    /// Set to `true` while editing views.
    public var editMode = false {
        didSet {
            
            if libraryButton.alpha == 0 {
                UIView.animate(withDuration: 0.5) {
                    self.libraryButton.alpha = 1
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.libraryButton.alpha = 0
                }
            }
            
            if editMode {
                editButton.setTitle("Done", for: .normal)
            } else {
                editButton.setTitle("Edit", for: .normal)
                UIView.animate(withDuration: 0.5) {
                    self.libraryView.alpha = 0
                }
            }
            
            for grid in [topLeft, topRight, bottomLeft, bottomRight] {
                grid.isHidden = !editMode
            }
        }
    }
    
    /// The library.
    let libraryViewController = LibraryViewController()
    
    /// The view containing the library.
    var libraryView: UIView!
    
    /// Toggles edit mode.
    @objc func edit() {
        editMode = !editMode
    }
    
    /// Inspects view.
    @objc func inspect(_ sender: UILongPressGestureRecognizer) {
        
        guard editMode, let view = sender.view else {
            return
        }
        
        let inspector = InspectorViewController(view: view)
        
        let controller = UINavigationController(rootViewController: inspector)
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        controller.popoverPresentationController?.sourceRect = view.bounds
        controller.popoverPresentationController?.sourceView = view
        controller.popoverPresentationController?.delegate = inspector
        present(controller, animated: true, completion: nil)
        
        if libraryView.alpha == 1 {
            UIView.animate(withDuration: 0.5) {
                self.libraryView.alpha = 0
                self.libraryButton.alpha = 1
                self.editButton.alpha = 1
            }
        }
    }
    
    /// Shows or hides the library.
    @objc func showLibrary() {
        if libraryView.alpha == 0 {
            UIView.animate(withDuration: 0.5) {
                self.libraryView.alpha = 1
                self.libraryButton.alpha = 0
                self.editButton.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.libraryView.alpha = 0
                self.libraryButton.alpha = 1
                self.editButton.alpha = 1
            }
        }
    }
    
    // MARK: - Grids
    
    private var topLeft = UIView()
    private var topRight = UIView()
    private var bottomLeft = UIView()
    private var bottomRight = UIView()
    
    private func setupGrids(size: CGSize) {
        
        topLeft.frame.origin = .zero
        topRight.frame.origin = CGPoint(x: size.width/2, y: 0)
        bottomLeft.frame.origin = CGPoint(x: 0, y: size.height/2)
        bottomRight.frame.origin = CGPoint(x: size.width/2, y: size.height/2)
        for grid in [topLeft, topRight, bottomLeft, bottomRight] {
            grid.layer.borderWidth = 1
            grid.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            grid.frame.size = CGSize(width: size.width/2, height: size.height/2)
            grid.isUserInteractionEnabled = false
            if grid.superview == nil {
                view.insertSubview(grid, at: 0)
            }
            grid.isHidden = !editMode
        }
    }
    
    // MARK: - View controller
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        libraryView = libraryNavigationController.view
        libraryViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(showLibrary))
        libraryViewController.title = "Drag and Drop items"
        
        view.addInteraction(UIDropInteraction(delegate: self))
        view.addSubview(libraryView)
        view.addSubview(libraryButton)
        view.addSubview(editButton)
        view.backgroundColor = .white
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupGrids(size: view.frame.size)
        
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = view.tintColor
        editButton.setTitle("Edit", for: .normal)
        editButton.frame = CGRect(x: 10, y: view.frame.size.height-50, width: 80, height: 30)
        editButton.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        
        libraryButton.setTitleColor(.white, for: .normal)
        libraryButton.backgroundColor = view.tintColor
        libraryButton.setTitle("Library", for: .normal)
        libraryButton.frame = CGRect(x: view.frame.width-90, y: view.frame.size.height-50, width: 80, height: 30)
        libraryButton.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin]
        
        libraryView.frame = CGRect(x: 0, y: view.frame.size.height-150, width: view.frame.width, height: 150)
        libraryView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        libraryView.alpha = 0
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupGrids(size: view.frame.size)
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setupGrids(size: size)
    }
    
    // MARK: - Drop interaction delegate
    
    public func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        if let index = session.items.first?.localObject as? Int {
            let item = Items[index]
            let view = item.type.init()
            view.addInteraction(UIDragInteraction(delegate: view))
            view.center = session.localDragSession?.location(in: self.view) ?? session.location(in: self.view)
            
            let inspectGesture = UILongPressGestureRecognizer(target: self, action: #selector(inspect(_:)))
            view.addGestureRecognizer(inspectGesture)
                        
            view.isUserInteractionEnabled = true
            self.view.addSubview(view)
            item.configure(view: view)
            showLibrary()
        } else if let view = session.items.first?.localObject as? UIView {
            view.center = session.location(in: self.view)
        }
    }
    
    public func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        
        if session.items.first?.localObject is Int {
            return UIDropProposal(operation: .copy)
        } else {
            return UIDropProposal(operation: .move)
        }
    }
}
