import SwiftUI

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
    @Environment(\.colorScheme) var colorScheme
    
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
                    .foregroundColor(.secondary)
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
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
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
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
                .foregroundColor(.primary)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Subscription")
    }
}

struct AccountSubscriptionViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AccountSettingsView()
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                AccountSettingsView()
            }
            .preferredColorScheme(.dark)
            
            NavigationView {
                SubscriptionView()
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                SubscriptionView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
