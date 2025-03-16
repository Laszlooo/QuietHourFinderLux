import SwiftUI

struct SpaceDetailView: View {
    let space: Space
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ScrollView {
            VStack {
                Image(space.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .frame(maxWidth: 300)
                    .cornerRadius(15)
                    .clipped()
                    .padding(.vertical)
                
                StarRatingView(rating: space.rating)

                Text(space.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text(space.description)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle(space.title)
        .background(colorScheme == .dark ? Color(UIColor.systemBackground) : Color(UIColor.systemBackground))
    }
}

struct SpaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SpaceDetailView(space: .init(id: 1, title: "Test Space", description: "This is a test space.", image: "placeholder", rating: 5))
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                SpaceDetailView(space: .init(id: 1, title: "Test Space", description: "This is a test space.", image: "placeholder", rating: 5))
            }
            .preferredColorScheme(.dark)
        }
    }
}
