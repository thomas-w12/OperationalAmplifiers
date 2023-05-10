import SwiftUI

@main
struct MyApp: App {
    
    init() {
        FontHelper.registerFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
