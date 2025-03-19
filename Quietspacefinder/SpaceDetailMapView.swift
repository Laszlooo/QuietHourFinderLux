// SpaceDetailMapView.swift
import SwiftUI
import MapKit

// Using the existing SpaceAnnotation from HomeView.swift

struct SpaceDetailMapView: View {
    let title: String
    let coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        // Initialize the region with the space's coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Location")
                .font(.headline)
                .padding(.leading, 13)
            
            NavigationLink(destination: SpaceFullScreenMapView(title: title, coordinate: coordinate)) {
                Map(coordinateRegion: $region, annotationItems: [
                    SpaceAnnotation(coordinate: coordinate, title: title)
                ]) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray4))
                                .frame(width: 25, height: 25)
                            
                            Image(systemName: "ear.fill")
                                .renderingMode(.template)
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                    }
                }
                .frame(height: 200)
                .cornerRadius(15)
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.top, 10)
    }
}

struct SpaceFullScreenMapView: View {
    let title: String
    let coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion
    @Environment(\.colorScheme) var colorScheme
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        _region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            annotationItems: [SpaceAnnotation(coordinate: coordinate, title: title)]
        ) { annotation in
            MapAnnotation(coordinate: annotation.coordinate) {
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
                    Text(annotation.title ?? "")
                        .font(.caption)
                        .fontWeight(Font.Weight.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct SpaceDetailMapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SpaceDetailMapView(
                title: "Serene Library",
                coordinate: CLLocationCoordinate2D(latitude: 49.6116, longitude: 6.1319)
            )
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
            
            SpaceDetailMapView(
                title: "Serene Library",
                coordinate: CLLocationCoordinate2D(latitude: 49.6116, longitude: 6.1319)
            )
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
