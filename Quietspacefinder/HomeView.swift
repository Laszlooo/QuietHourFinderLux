import SwiftUI

struct CardHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct HomeView: View {
    @State private var maxCardHeight: CGFloat = 0
    @StateObject var viewModel = SpaceViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Spaces")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.spaces) { space in
                                SpaceCardView(space: space)
                                    .frame(width: 200)
                                    .background(GeometryReader { proxy in
                                        Color.clear
                                            .preference(key: CardHeightKey.self, value: proxy.size.height)
                                    })
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                    }
                    .frame(height: maxCardHeight + 0) // Dynamically set height
                    .onPreferenceChange(CardHeightKey.self) { newHeight in
                        maxCardHeight = newHeight
                    }
                }
                .padding(.top)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
