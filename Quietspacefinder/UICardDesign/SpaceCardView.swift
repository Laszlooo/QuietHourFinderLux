import SwiftUI

struct SpaceCardView: View {
    let space: Space
    @Environment(\.colorScheme) var colorScheme

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
                .padding(.vertical, 3)
                .padding(.horizontal, 16)
                
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.headline)
                        .padding(.bottom, 3)
                    Text(space.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
            .cornerRadius(15)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(4)
    }
}

struct SpaceCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpaceCardView(space: Space(id: 1, title: "Test Space", description: "A test description.", image: "placeholder", rating: 5))
                .preferredColorScheme(.light)
            
            SpaceCardView(space: Space(id: 1, title: "Test Space", description: "A test description.", image: "placeholder", rating: 5))
                .preferredColorScheme(.dark)
        }
    }
}
