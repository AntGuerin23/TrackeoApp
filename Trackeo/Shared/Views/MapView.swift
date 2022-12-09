import SwiftUI
import MapKit
import CoreLocation
import Combine

struct MapView: View {
    @StateObject var manager = LocationManager()
    @State private var locations = [Location]()
    @State private var timer: AnyCancellable?

    @State var tracking:MapUserTrackingMode = .follow

    var body: some View {
        ZStack {
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: locations) { location in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                        CatAnnotation()
                    }
                }.edgesIgnoringSafeArea(.top)
            
            VStack {
                HStack {
                    Spacer()
                    Button() {
                        Task {
                            await checkForNewLocations()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }.padding()
                }
                Spacer()
            }
        }.task {
            timer = Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    Task {
                        await checkForNewLocations()
                    }
                }
        }.onDisappear() {
            timer?.cancel()
        }
    }
    
    func checkForNewLocations() async {
        Task {
            await ApiClient.ping()
            let location = await ApiClient.getLocation()
            if (location?.latitude == locations.last?.latitude && location?.longitude == locations.last?.longitude) {
                return;
            }
            locations = [Location]()
            locations.append(Location(id: UUID(), latitude: location!.latitude, longitude: location!.longitude))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
