import SwiftUI

struct CompassView: View {
        
    @ObservedObject var compass = Compass()
    
    var body: some View {
        VStack {
            Text("100 m").font(.system(size: 40)).padding(8)
            
            ZStack {
                Circle().foregroundColor(Color.mint).frame(width: 330, height: 330).shadow(radius: 10)
                Circle().foregroundColor(Color.white)
                    .frame(width: 300, height: 300)

                Image(systemName: "arrow.up").font(.system(size: 200)).rotationEffect(Angle(degrees: compass.degrees))
                    .foregroundColor(Color.cyan)
                

            }

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
