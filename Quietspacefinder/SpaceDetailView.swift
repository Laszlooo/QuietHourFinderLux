import SwiftUI

struct SpaceDetailView: View {
    let space: Space
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedImageIndex = 0
    @State private var comments: [Comment] = []
    @State private var newComment: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ImageGalleryView(images: space.images, selectedImageIndex: $selectedImageIndex)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(space.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    HStack {
                        StarRatingView(rating: space.rating)
                        Text(String(format: "%.1f", space.rating))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("About this space")
                        .font(.headline)
                    
                    Text(space.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                CommentSectionView(comments: $comments, newComment: $newComment, addComment: addComment)
                    .padding(.horizontal)
            }
        }
        .navigationTitle(space.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(colorScheme == .dark ? Color.black : Color.white)
    }
    
    private func addComment() {
        let comment = Comment(id: UUID(), text: newComment, date: Date())
        comments.append(comment)
        newComment = ""
    }
}

struct SpaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SpaceDetailView(space: .init(id: 1, title: "Luxury Beach Villa", description: "A stunning beachfront villa with modern amenities and breathtaking views.", images: ["placeholder", "mountain"], rating: 4.8))
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                SpaceDetailView(space: .init(id: 1, title: "Luxury Beach Villa", description: "A stunning beachfront villa with modern amenities and breathtaking views.", images: ["placeholder"], rating: 4.8))
            }
            .preferredColorScheme(.dark)
        }
    }
}
