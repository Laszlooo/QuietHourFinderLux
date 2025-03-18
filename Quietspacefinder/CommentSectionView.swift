import SwiftUI

struct CommentSectionView: View {
    @Binding var comments: [Comment]
    @Binding var newComment: String
    let addComment: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Guest Reviews")
                .font(.headline)
            
            if comments.isEmpty {
                Text("No reviews yet. Be the first to comment!")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                LazyVStack {
                    ForEach(comments) { comment in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(comment.text)
                                .font(.body)
                            Text(comment.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            
            HStack {
                TextField("Write a review...", text: $newComment)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addComment) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                }
                .disabled(newComment.isEmpty)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CommentSectionView_Previews: PreviewProvider {
    static var previews: some View {
        CommentSectionView(
            comments: .constant([Comment(id: UUID(), text: "Great place!", date: Date())]),
            newComment: .constant(""),
            addComment: {}
        )
        .previewLayout(.sizeThatFits)
    }
}
