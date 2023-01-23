import Foundation

class PersonDetailsViewModel: ObservableObject {
    let id: Int
    let type: Results

    @Published var details: PersonDetails? = nil

    init(id: Int, type: Results) {
        self.id = id
        self.type = type
        self.loadDetails()
    }

    func loadDetails() {
//        var parameters: [String: Any]
        APIService.get(endpoint: "\(type)/\(id)", parameters: ["append_to_response": "combined_credits,images"]) { [weak self] (details: PersonDetails) in
            self?.details = details
        }
    }
}
