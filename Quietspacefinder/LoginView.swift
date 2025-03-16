import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginFormShown = false
    @State private var showPassword = false
    @State private var isAuthenticating = false
    @State private var loginError = false
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isPresented = false
                    }
                }
            
            // Login form
            VStack(spacing: 0) {
              
                
                VStack(spacing: 25) {
                    // Handle at top for pulling
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 5)
                        .padding(.top, 10)
                    
                    // Title
                    Text("Sign In")
                        .font(.system(size: 28, weight: .bold))
                    
                    // Form fields
                    VStack(spacing: 20) {
                        // Email field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.headline)
                                .foregroundColor(.primary.opacity(0.8))
                            
                            TextField("you@example.com", text: $email)
                                .padding()
                                .background(colorScheme == .dark ? Color(UIColor.systemGray6) : Color(UIColor.lightGray))
                                .cornerRadius(10)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Password")
                                .font(.headline)
                                .foregroundColor(.primary.opacity(0.8))
                            
                            HStack {
                                if showPassword {
                                    TextField("Password", text: $password)
                                        .padding()
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: $password)
                                        .padding()
                                        .autocapitalization(.none)
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 15)
                            }
                            .background(colorScheme == .dark ? Color(UIColor.systemGray6) : Color(UIColor.lightGray))
                            .cornerRadius(10)
                        }
                        
                        // Forgot password
                        HStack {
                            Spacer()
                            Button(action: {
                                // Forgot password action
                            }) {
                                Text("Forgot Password?")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        // Login error message
                        if loginError {
                            Text("Invalid email or password")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        // Sign in button
                        Button(action: {
                            withAnimation {
                                isAuthenticating = true
                                
                                // Simulate authentication
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    isAuthenticating = false
                                    
                                    // For demo: Consider any non-empty input as valid
                                    if !email.isEmpty && !password.isEmpty {
                                        isPresented = false
                                    } else {
                                        loginError = true
                                    }
                                }
                            }
                        }) {
                            ZStack {
                                Text("Sign In")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .opacity(isAuthenticating ? 0 : 1)
                                
                                if isAuthenticating {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        .disabled(isAuthenticating)
                    }
                    
                    // Sign up option
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            // Navigate to sign up
                        }) {
                            Text("Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                }
                .padding(.horizontal, 25)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(30, corners: [.topLeft, .topRight])
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                isLoginFormShown = true
            }
        }
    }
}

// Extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView(isPresented: .constant(true))
                .preferredColorScheme(.light)
            
            LoginView(isPresented: .constant(true))
                .preferredColorScheme(.dark)
        }
    }
}
