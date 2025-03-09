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
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                
                VStack(alignment: .leading) {
                    Text(space.title)
                        .font(.headline)
                        .padding(.bottom, 3)
                    Text(space.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            }
            .background(Color.white)
            .cornerRadius(15)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            .padding(4) 
    }
}

struct SpaceCardView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceCardView(space: Space(id: 1, title: "Test Space", description: "A test description.", image: "placeholder", rating: 5))
    }
}
