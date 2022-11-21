import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.01498881049655, longitude: -73.14951453973829), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @StateObject var manager = LocationManager()
    @State private var locations = [Location]()

    var body: some View {
        Button("Update location")  {
            Task {
                await ApiClient.ping()
                let location = await ApiClient.getLocation()
                locations = [Location]()
                locations.append(Location(id: UUID(), latitude: location!.latitude, longitude: location!.longitude))
            }
        }
        Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: locations) { location in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                CatAnnotation()
                //Text("Criss")
            }
        }.edgesIgnoringSafeArea(.top)

    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
