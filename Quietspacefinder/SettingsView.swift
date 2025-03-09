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
    @Published var theme: AppTheme = .system {
        didSet {
            UserDefaults.standard.set(theme.rawValue, forKey: "selectedTheme")
        }
    }
    
    init() {
        if let savedTheme = UserDefaults.standard.string(forKey: "selectedTheme"),
           let theme = AppTheme(rawValue: savedTheme) {
            self.theme = theme
        }
    }
}

struct SettingsView: View {
    @StateObject private var themeManager = ThemeManager()
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Account")) {
                NavigationLink(destination: AccountSettingsView()) {
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                        Text("Account Settings")
                    }
                }
            }
            
            Section(header: Text("Subscription")) {
                NavigationLink(destination: SubscriptionView()) {
                    HStack {
                        Image(systemName: "creditcard")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                        Text("Manage Subscription")
                    }
                }
                
                HStack {
                    Text("Current Plan")
                    Spacer()
                    Text("Free")
                        .foregroundColor(.gray)
                }
            }
            
            Section(header: Text("Appearance")) {
                ForEach(AppTheme.allCases) { theme in
                    Button(action: {
                        themeManager.theme = theme
                    }) {
                        HStack {
                            Image(systemName: theme.icon)
                                .foregroundColor(getIconColor(for: theme))
                                .font(.system(size: 20))
                            
                            Text(theme.rawValue)
                            
                            Spacer()
                            
                            if themeManager.theme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Section(header: Text("About")) {
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.gray)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
    }
}

struct AccountSettingsView: View {
    @State private var username = "User"
    @State private var email = "user@example.com"
    
    var body: some View {
        Form {
            Section(header: Text("Profile")) {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button(action: {
                    // Sign out logic
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Account")
    }
}

struct SubscriptionView: View {
    var body: some View {
        List {
            Section(header: Text("Current Plan")) {
                HStack {
                    Text("Free Tier")
                    Spacer()
                    Text("Active")
                        .foregroundColor(.green)
                }
                
                Text("Upgrade to get access to premium quiet spaces and ad-free experience.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.vertical, 4)
            }
            
            Section(header: Text("Available Plans")) {
                Button(action: {
                    // Upgrade logic
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Premium Monthly")
                                .fontWeight(.semibold)
                            Text("$4.99/month")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.primary)
                
                Button(action: {
                    // Upgrade logic
                }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Premium Yearly")
                                .fontWeight(.semibold)
                            Text("$39.99/year")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.primary)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Subscription")
    }
}

extension SettingsView {
    func getIconColor(for theme: AppTheme) -> Color {
        switch theme {
        case .system:
            return .blue
        case .light:
            return .orange
        case .dark:
            return .indigo
        }
    }
}

struct ThemeAwareView<Content: View>: View {
    @StateObject private var themeManager = ThemeManager()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .preferredColorScheme(themeManager.theme.colorScheme)
            .environmentObject(themeManager)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
