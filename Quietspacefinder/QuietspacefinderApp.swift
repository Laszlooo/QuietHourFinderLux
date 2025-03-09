import SwiftUI

@main
struct QuietspacefinderApp: App {
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(themeManager.theme.colorScheme)
                .environmentObject(themeManager)
        }
    }
}
