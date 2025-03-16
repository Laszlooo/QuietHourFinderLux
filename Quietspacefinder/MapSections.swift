// MapSections.swift
import SwiftUI
import MapKit

// Subview for the Spaces section
struct SpacesSection: View {
    @ObservedObject var viewModel: SpaceViewModel
    
    var body: some View {
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
        }
    }
}

struct MapsSection: View {
    @Binding var region: MKCoordinateRegion
    var annotations: [SpaceAnnotation]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Maps")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            
            NavigationLink(destination: FullScreenMapView()) {
                Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                    MapAnnotation(coordinate: annotation.coordinate) {
                      
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray4))
                                .frame(width: 25, height: 25)
                            
                            Image(systemName: "ear.fill") // Changed to a valid SF Symbol
                                .renderingMode(.template) // Required for coloring
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                    }
                }
                .frame(height: 400)
                .cornerRadius(15)
                .padding(.horizontal)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
