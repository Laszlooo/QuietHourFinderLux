import SwiftUI

@main
struct QuietspacefinderApp: App {
    @State private var showLoginScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                if showLoginScreen {
                    LoginView(isPresented: $showLoginScreen)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
    }
}
