import Foundation

class SpaceViewModel: ObservableObject {
    @Published var spaces: [Space] = []

    init() {
        loadSpaces()
    }

    func loadSpaces() {
        if let url = Bundle.main.url(forResource: "spaces", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decodedSpaces = try? decoder.decode([Space].self, from: data) {
                self.spaces = decodedSpaces
            }
        }
    }
}
