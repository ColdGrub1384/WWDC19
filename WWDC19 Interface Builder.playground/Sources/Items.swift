import PlaygroundSupport

/// Items that can be placed from the library.
public var Items: [InterfaceBuilderView] = [] {
    didSet {
        InterfaceBuilderViewController.shared.libraryViewController.tableView.reloadData()
    }
}
