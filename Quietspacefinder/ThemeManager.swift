import SwiftUI

extension View {
    func withThemeApp() -> some View {
        modifier(ThemeModifier())
    }
}

struct ThemeModifier: ViewModifier {
    @StateObject private var themeManager = ThemeManager()
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(themeManager.theme.colorScheme)
            .environmentObject(themeManager)
    }
}
