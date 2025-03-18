import SwiftUI

struct ImageGalleryView: View {
    let images: [String]
    @Binding var selectedImageIndex: Int
    
    var body: some View {
        VStack(spacing: 10) {
            // Main Image TabView with lazy loading
            TabView(selection: $selectedImageIndex) {
                LazyVStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        let imageName = images[index]
                        Image(uiImage: loadImage(imageName) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(15)
                            .tag(index)
                    }
                }
            }
            .frame(height: 300)
            .tabViewStyle(PageTabViewStyle())
            .overlay(
                HStack {
                    ForEach(0..<images.count, id: \.self) { index in
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(selectedImageIndex == index ? .blue : .gray)
                    }
                }
                .padding(.bottom, 5),
                alignment: .bottom
            )
            
            // Thumbnail ScrollView with improved layout
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<images.count, id: \.self) { index in
                        let imageName = images[index]
                        Image(uiImage: loadImage(imageName) ?? UIImage(systemName: "photo")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .clipped()
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedImageIndex == index ? Color.blue : Color.clear, lineWidth: 2)
                            )
                            .opacity(selectedImageIndex == index ? 1.0 : 0.6)
                            .onTapGesture {
                                withAnimation {
                                    selectedImageIndex = index
                                }
                            }
                    }
                }
                .padding(.vertical, 5) // Add vertical padding inside the ScrollView
            }
            .padding(.horizontal, 20) // Horizontal padding outside the ScrollView
        }
    }
    
    // Helper function to load UIImage from asset catalog
    private func loadImage(_ name: String) -> UIImage? {
        if !name.isEmpty {
            if let image = UIImage(named: name) {
                print("Successfully loaded image: \(name)")
                return image
            } else {
                print("Failed to load image: \(name)")
            }
        }
        return UIImage(systemName: "photo")
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryView(images: ["placeholder", "mountain"], selectedImageIndex: .constant(0))
            .previewLayout(.sizeThatFits)
    }
}
