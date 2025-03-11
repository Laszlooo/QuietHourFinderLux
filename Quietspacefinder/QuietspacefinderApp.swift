import SwiftUI

@main
struct QuietspacefinderApp: App {
    @StateObject private var themeManager = ThemeManager()
    @State private var showLoginScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .preferredColorScheme(themeManager.theme.colorScheme)
                    .environmentObject(themeManager)
                
                if showLoginScreen {
                    LoginView(isPresented: $showLoginScreen)
                        .environmentObject(themeManager)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
    }
}
