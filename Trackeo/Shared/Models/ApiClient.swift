import Foundation

class ApiClient {
    private static let baseUrl = "http://159.203.36.1"
    private static let pingEndpoint = "/ping"
    private static let locationsEndpoint = "/locations"

    static func ping() async {
        await callEndpoint(pingEndpoint);
    }

    static func getLocation() async -> Location? {
        //TODO : Add security, require secret so that not everybody can get locations that knows the ip address
        guard let response = await callEndpoint(locationsEndpoint) else {
            print("Cannot access api")
            return nil
        }
        let jsonData = String(decoding: response.0, as: UTF8.self).data(using: .utf8)
        do {
            return try JSONDecoder().decode([Location].self, from: jsonData!).last
        } catch {
            print("Couldn't decode locations")
            return nil
        }
    }
    
    private static func callEndpoint(_ endpoint : String) async -> (Data, URLResponse)? {
        do {
            let url = URL(string: baseUrl + endpoint)!
            return try await URLSession.shared.data(from: url)
        } catch let error {
            print(error)
            return nil
        }
    }
}
