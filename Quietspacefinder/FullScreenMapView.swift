import SwiftUI
import MapKit

// First, create a struct for your custom annotation
struct LandmarkAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

struct FullScreenMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.8152995, longitude: 6.13332),
        span: MKCoordinateSpan(latitudeDelta: 1.15, longitudeDelta: 0.05)
    )
    
    // Add some sample annotations
    private let annotations = [
        LandmarkAnnotation(
            coordinate: CLLocationCoordinate2D(latitude: 49.611621, longitude: 6.131935),
            title: "Luxembourg City Center"
        ),
        LandmarkAnnotation(
            coordinate: CLLocationCoordinate2D(latitude: 49.6277, longitude: 6.1598),
            title: "Kirchberg Plateau"
        )
    ]
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: annotations
        ) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
                // Custom marker view
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 25, height: 25)
                        
                        Image(systemName: "ear.fill")
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                    }
                    Text(annotation.title)
                        .font(.caption)
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle("Full Screen Map", displayMode: .inline)
    }
}

struct FullScreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FullScreenMapView()
            }
            .preferredColorScheme(.light)
            
            NavigationView {
                FullScreenMapView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
