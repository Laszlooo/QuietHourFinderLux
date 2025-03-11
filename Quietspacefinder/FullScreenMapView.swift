import SwiftUI
import MapKit

struct FullScreenMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.8152995, longitude: 6.13332),
        span: MKCoordinateSpan(latitudeDelta: 1.15, longitudeDelta: 0.05)
    )
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        Map(
            coordinateRegion: $region
        )
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Full Screen Map", displayMode: .inline)
        .colorScheme(colorScheme) // Ensure map respects system appearance
        .preferredColorScheme(themeManager.theme.colorScheme)
    }
}

struct FullScreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FullScreenMapView()
                    .environmentObject(ThemeManager())
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                FullScreenMapView()
                    .environmentObject(ThemeManager())
            }
            .preferredColorScheme(.dark)
        }
    }
}
