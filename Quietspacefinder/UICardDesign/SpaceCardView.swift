import SwiftUI

struct SpaceCardView: View {
    let space: Space

    var body: some View {
            VStack {
                Image(space.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .frame(maxWidth: 200)
                    .cornerRadius(15)
                    .clipped()
                    .padding(10)
                
                HStack {
                               StarRatingView(rating: space.rating)
                               Spacer()
                           }
                           .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(space.description)
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

struct SpaceCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceCardView(space: Space(id: 1, title: "Test Space", description: "A test description.", image: "placeholder", rating: 5))
    }
}
