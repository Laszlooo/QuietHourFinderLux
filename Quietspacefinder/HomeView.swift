// HomeView.swift
import SwiftUI
import MapKit

// Create a struct for your custom annotation
struct SpaceAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String?
}

struct HomeView: View {
    @StateObject var viewModel = SpaceViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 49.8152995, longitude: 6.13332),
        span: MKCoordinateSpan(latitudeDelta: 1.15, longitudeDelta: 0.05)
    )
    @Environment(\.colorScheme) var colorScheme
    
    // Add annotations array
    @State private var annotations: [SpaceAnnotation] = [
        SpaceAnnotation(
            coordinate: CLLocationCoordinate2D(latitude: 49.6116, longitude: 6.1319),
            title: "Luxembourg City"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    SpacesSection(viewModel: viewModel)
                    MapsSection(region: $region, annotations: annotations)
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
            .background(colorScheme == .dark ? Color.black : Color(.systemGray6))
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
