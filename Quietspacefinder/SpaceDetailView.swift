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
                
                // Modified VStack with frame alignment
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
                .padding(.leading, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("About this space")
                        .font(.headline)
                    
                    Text(space.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 13)
                .padding(.trailing, 10)
                
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
                SpaceDetailView(space: .init(id: 1, title: "Super hot & quiet", description: "A stunning beachfront hot and quiet space with modern amenities and breathtaking views. nearby beach and mountains too. people love working or studying here", images: ["placeholder", "mountain"], rating: 4.8))
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                SpaceDetailView(space: .init(id: 1, title: "Luxury Beach Villa", description: "A stunning beachfront villa with modern amenities and breathtaking views.", images: ["placeholder"], rating: 4.8))
            }
            .preferredColorScheme(.dark)
        }
    }
}
