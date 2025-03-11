import SwiftUI

// Create an AppTheme enum for proper theme management
enum AppTheme: String, CaseIterable, Identifiable {
    case system = "Default"
    case light = "Light"
    case dark = "Dark"
    
    var id: String { self.rawValue }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
    
    var icon: String {
        switch self {
        case .system: return "circle.lefthalf.filled"
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        }
    }
}

// Create a ThemeManager to handle theme changes application-wide
class ThemeManager: ObservableObject {
    @Published var theme: AppTheme {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: "selectedTheme")
        }
    }
    
    init() {
        // Get saved theme or default to system
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = AppTheme(rawValue: savedTheme) {
            self.theme = theme
        } else {
            self.theme = .system
        }
    }
}

// View modifier to apply theme to any view
struct ThemeModifier: ViewModifier {
    @ObservedObject var themeManager: ThemeManager
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(themeManager.theme.colorScheme)
    }
}

// Extension to make it easier to apply the theme to any view
extension View {
    func withTheme(_ themeManager: ThemeManager) -> some View {
        modifier(ThemeModifier(themeManager: themeManager))
    }
}
