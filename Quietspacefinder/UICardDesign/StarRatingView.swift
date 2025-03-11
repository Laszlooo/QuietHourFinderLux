import SwiftUI

struct StarRatingView: View {
    let rating: Int
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ?
                                     (colorScheme == .dark ? Color.blue : Color.blue) :
                                    Color.secondary)
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarRatingView(rating: 4)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .padding()
            
            StarRatingView(rating: 4)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
