import SwiftUI
import MapKit

struct FullScreenMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.8152995, longitude: 6.13332),
        span: MKCoordinateSpan(latitudeDelta: 1.15, longitudeDelta: 0.05)
    )

    var body: some View {
           Map(
               coordinateRegion: $region // Pass the region directly
           )
           .edgesIgnoringSafeArea(.all) // Makes the map full screen
           .navigationBarTitle("Full Screen Map", displayMode: .inline)
       }
   }

struct FullScreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenMapView()
    }
}
