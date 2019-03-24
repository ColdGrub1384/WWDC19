//#-hidden-code
import PlaygroundSupport
import UIKit

NSSetUncaughtExceptionHandler { (exception) in
    print(exception.reason ?? "")
    UIPasteboard.general.string = exception.reason
    PlaygroundPage.current.finishExecution()
}

Items = [
    Label(),
    Button(),
    RoundedRectButton(),
    ActivityIndicatorView(),
    Switch(),
    Slider(),
    Stepper(),
    TextField(),
    NavigationBar(),
]

PlaygroundPage.current.liveView = InterfaceBuilderViewController.shared

//#-end-hidden-code
//: # Interface Builder
//: My WWDC19 project. A simple interface builder.
//:
//: This playgrounds allows us to create a basic view without code.
//: This has no real utility, just for fun.

//: # How it works?
//: If you run the playground, there will be an `'Edit'` button at top left. Press it and a `'Library'` button will be shown. If you press it, a views library will appear. To place a view, drag and drop it into the blank area. Then, you can move it by dragging. If you want to change or see properties of a view, long press it. An inspector will be shown, you can then edit values or remove the view. To stop edit mode, just press `'Done'` at top left.
