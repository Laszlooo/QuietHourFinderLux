import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var isAuthenticating = false
    @State private var loginError = false
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            // Semi-transparent background
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        isPresented = false
                    }
                }
            
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                            isPresented = false
                        }
                    })
                    {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.secondary)
                            .padding(.top, 20)
                            .padding(.trailing, 20)
                    }
                }
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("Sign In")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.top)
                        
                        VStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Email")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
                                TextField("you@example.com", text: $email)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .foregroundColor(.primary)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                
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
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .foregroundColor(.primary)
                            }
                            
                            HStack {
                                Spacer()
                                Button(action: {}) {
                                    Text("Forgot Password?")
                                        .font(.subheadline)
                                        .foregroundColor(.accentColor)
                                }
                            }
                            
                            if loginError {
                                Text("Invalid email or password")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    isAuthenticating = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        isAuthenticating = false
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
                                .background(Color.accentColor)
                                .cornerRadius(10)
                            }
                            .disabled(isAuthenticating)
                            
                            HStack {
                                Text("Don't have an account?")
                                    .foregroundColor(.secondary)
                                
                                Button(action: {}) {
                                    Text("Sign Up")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .padding(.top, 5)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding(.horizontal, 25)
                }
            }
            .background(Color(.systemBackground))
            .cornerRadius(30, corners: [.topLeft, .topRight])
            .ignoresSafeArea(.container, edges: .bottom)
            .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
        }
    }
}

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
