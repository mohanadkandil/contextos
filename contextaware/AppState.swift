import SwiftUI
import AppKit

class AppState: ObservableObject {
    @Published var summary: String = "Waiting for summary..."
    @Published var mode: TextExtractionMode = .selectedText
    @Published var isLoading: Bool = false
    var window: NSWindow?
    
    enum TextExtractionMode {
        case selectedText
        case allText
    }
    
    init() {
        setupFloatingWindow()
        setupGlobalShortcut()
    }
    
    func setupFloatingWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 200),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.level = .floating
        window.title = "Summary App"
        window.contentView = NSHostingView(rootView: ContentView(appState: self))
        window.center()
        window.makeKeyAndOrderFront(nil)
        self.window = window
    }
    
    func setupGlobalShortcut() {
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains(.command) && event.keyCode == 12 {
                if self.window?.isVisible == true {
                    self.window?.close()
                } else {
                    self.setupFloatingWindow()
                }
            }
        }
    }
}
