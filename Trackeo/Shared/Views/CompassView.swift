import SwiftUI

struct CompassView: View {
    var body: some View {
        HStack {
            
        }.task {
            print(LocationCalculator.calculateDistance( firstPoint: Location(id: UUID(), latitude: 46.03990770130233, longitude: -73.12967918789305), secondPoint: Location(id: UUID(), latitude: 46.039668691550595, longitude: -73.14779880378347)))
        }
    }
}

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}
