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
                HStack {
                    Image(systemName: "paintbrush")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                    
                    Picker("Theme", selection: $themeManager.theme) {
                        ForEach(AppTheme.allCases) { theme in
                            HStack {
                                Image(systemName: theme.icon)
                                Text(theme.rawValue)
                            }
                            .tag(theme)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
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
