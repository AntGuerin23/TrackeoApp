import SwiftUI
import Combine

struct CompassView: View {
    @ObservedObject private var compass = Compass()
    @StateObject var manager = LocationManager()
    @State private var timer: AnyCancellable?
    @State private var apiTimer: AnyCancellable?
    @State private var distance : Double = 0
    @State private var userLocation : Location?
    
    var body: some View {
        VStack {
            Text("\(distance, specifier: "%.1f") m").font(.system(size: 40)).padding(8)
            
            ZStack {
                Circle().foregroundColor(Color.mint).frame(width: 330, height: 330).shadow(radius: 10)
                Circle().foregroundColor(Color.white)
                    .frame(width: 300, height: 300)
                Image(systemName: "arrow.up").font(.system(size: 200)).rotationEffect(getHeading())
                    .foregroundColor(Color.cyan)
            }
        }.onAppear() {
            startTimers()
        }.onDisappear() {
            timer?.cancel()
            apiTimer?.cancel()
        }
    }
    
    private func startTimers() {
        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task {
                    let distanceDouble = LocationCalculator.calculateDistance(firstPoint: userLocation ?? manager.getUserLocation(), secondPoint: manager.getUserLocation())
                    distance = distanceDouble
                }
            }
        apiTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                Task {
                    userLocation = await ApiClient.getLocation() ?? userLocation
                    await ApiClient.ping()
                }
            }
    }
    
    private func getHeading() -> Angle {
        let bearing = LocationCalculator.getBearing(currentLocation: manager.getUserLocation(), trackerLocation: userLocation ?? manager.getUserLocation())
        return Angle(degrees: bearing - compass.degrees)
    }
}

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}
