import SwiftUI

struct StarRatingView: View {
    let rating: Double // Changed from Int to Double
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: starImage(for: Double(index)))
                    .foregroundColor(starColor(for: Double(index)))
            }
        }
    }
    
    // Determine the appropriate star image based on the rating
    private func starImage(for star: Double) -> String {
        if star <= rating {
            return "star.fill" // Full star
        } else if star - 0.5 <= rating {
            return "star.leadinghalf.filled" // Half star
        } else {
            return "star" // Empty star
        }
    }
    
    // Determine the color based on whether the star is filled
    private func starColor(for star: Double) -> Color {
        if star <= rating {
            return colorScheme == .dark ? .blue : .blue // Filled star color
        } else if star - 0.5 <= rating {
            return colorScheme == .dark ? .blue : .blue // Half-filled star color
        } else {
            return .secondary // Empty star color
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StarRatingView(rating: 4.7)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .padding()
            
            StarRatingView(rating: 4.7)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
            
            StarRatingView(rating: 3.2)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}
