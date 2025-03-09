import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode: Bool = false
    @State private var selectedThemeIndex = 0
    
    var themes = ["Default", "Dark", "Light"]
    
    var body: some View {
        List {
            Section(header: Text("Account")) {
                NavigationLink(destination: AccountSettingsView()) {
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                        Text("Account")
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
                Picker("Theme", selection: $selectedThemeIndex) {
                    ForEach(0..<themes.count, id: \.self) { index in
                        Text(themes[index])
                    }
                }
                
                Toggle("Dark Mode", isOn: $isDarkMode)
                    .onChange(of: isDarkMode) { newValue in
                        // Here you would implement the color scheme change
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
                            Text("$1.99/month")
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
                            Text("$19.99/year")
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
