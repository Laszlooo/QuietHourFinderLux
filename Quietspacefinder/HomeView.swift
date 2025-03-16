import SwiftUI
import MapKit

struct HomeView: View {
    @StateObject var viewModel = SpaceViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.8152995, longitude: 6.13332),
        span: MKCoordinateSpan(latitudeDelta: 1.15, longitudeDelta: 0.05)
    )
    @Environment(\.colorScheme) var colorScheme
    
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
                                NavigationLink(destination: SpaceDetailView(space: space)) {
                                    SpaceCardView(space: space)
                                        .frame(width: 250, height: 325)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    }
                    
                    Text("Maps")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    
                    NavigationLink(destination: FullScreenMapView()) {
                        Map(
                            coordinateRegion: $region
                        )
                        .frame(height: 400)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.3),
                                radius: 5, x: 5, y: 2)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top)
            }
            .navigationBarTitle(Text("Home"), displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.primary)
                }
            )
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .preferredColorScheme(.light)
            
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
