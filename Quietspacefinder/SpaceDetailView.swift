import SwiftUI

struct SpaceDetailView: View {
    let space: Space  

    var body: some View {
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
                .padding()

            Spacer()
        }
        .padding()
        .navigationTitle(space.title)
    }
}

#Preview {
    SpaceDetailView(space: .init(id: 1, title: "Test Space", description: "This is a test space.", image: "placeholder", rating: 5))
}
