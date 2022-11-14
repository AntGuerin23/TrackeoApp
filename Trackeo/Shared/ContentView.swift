import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
                .task({
                    await ApiClient.ping()
                    let location = await ApiClient.getLocations()
                    print(location!)
                    //Display last location in google map api
                    //Display last location in compass
                })

        //Bouton qui appelle /ping
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
