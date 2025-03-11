import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) var colorScheme
    
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
                        .foregroundColor(.secondary)
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
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Settings")
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SettingsView()
                    .environmentObject(ThemeManager())
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                SettingsView()
                    .environmentObject(ThemeManager())
            }
            .preferredColorScheme(.dark)
        }
    }
}
