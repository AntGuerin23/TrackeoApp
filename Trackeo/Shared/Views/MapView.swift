import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 46.01498881049655, longitude: -73.14951453973829), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @StateObject var manager = LocationManager()

    var body: some View {
//        Button("Update location")  {
//            Task {
//                await ApiClient.ping()
//                let location = await ApiClient.getLocations()
//                print(location!)
//                //Display last location in google map api
//                //Display last location in compass
//            }
//        }
//        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .ignoresSafeArea()
        Map(coordinateRegion: $manager.region, showsUserLocation: true, userTrackingMode: .constant(.follow)).edgesIgnoringSafeArea(.top)

    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
