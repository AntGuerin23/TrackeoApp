import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            MapView().tabItem{
                Label("Carte", systemImage: "map.fill")
            }
            CompassView().tabItem{
                Label("Boussole", systemImage: "safari.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
