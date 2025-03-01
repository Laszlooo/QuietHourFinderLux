import SwiftUI

struct TestHomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {

                    Text("Spaces")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                        .multilineTextAlignment(TextAlignment.center)
                        

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<5) { _ in
                                // Link to previously created UI element
                                CardView()
                                    .frame(width: 300)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
    }



// Example UI Element (from the previously created UI)
struct CardView: View {
    var body: some View {
        VStack {
            Image("placeholder") // Placeholder image
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(15)
                .clipped()

            VStack(alignment: .leading) {
                Text("Serene Library")
                    .font(.headline)
                    .padding(.bottom, 5)
                Text("A peaceful space perfect for focused work.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct TestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TestHomeView()
    }
}
