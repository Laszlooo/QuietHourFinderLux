import SwiftUI

struct ImageGalleryView: View {
    let images: [String]
    @Binding var selectedImageIndex: Int
    
    var body: some View {
        VStack(spacing: 10) {
            mainImageViewer
            thumbnailScrollView
        }
    }
    
    // Extracted main image viewer
    private var mainImageViewer: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<images.count, id: \.self) { index in
                Image(uiImage: loadImage(images[index]))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipped()
                    .cornerRadius(15)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 300)
        .overlay(paginationDots, alignment: .bottom)
    }
    
    // Extracted pagination dots
    private var paginationDots: some View {
        HStack(spacing: 8) {
            ForEach(0..<images.count, id: \.self) { index in
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(selectedImageIndex == index ? Color(.white) : .gray)
            }
        }
        .padding(.bottom, 10)
    }
    
    // Extracted thumbnail scroll view
    private var thumbnailScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(uiImage: loadImage(images[index]))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 70)
                        .clipped()
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedImageIndex == index ? Color(.systemFill) : Color.clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            withAnimation {
                                selectedImageIndex = index
                            }
                        }
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    // Helper function to load images with a fallback
    private func loadImage(_ name: String) -> UIImage {
        UIImage(named: name) ?? UIImage(systemName: "photo") ?? UIImage()
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView(
            images: ["placeholder", "mountain", "desert", "forest", "beach"],
            selectedImageIndex: .constant(0)
        )
        .previewLayout(.sizeThatFits)
    }
}
