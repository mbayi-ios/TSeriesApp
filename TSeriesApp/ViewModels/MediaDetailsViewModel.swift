import Foundation
import CodableX

class MediaDetailsViewModel: ObservableObject {
    private struct Options: OptionConfigurable {
        static var options: [Option] = [
            .init(MovieDetails.self),
            .init(TVDetails.self)
        ]
    }

    let id: Int
    let type: Results

    @Published var media: MediaDetails? = nil

    init(id: Int, type: Results) {
        self.id = id
        self.type = type
        self.loadDetails()
    }

    func loadDetails() {
        var parameters: [String: Any]
        if type == .movie {
            parameters = ["append_to_response": "similar,recommendations,credits,videos"]
        } else if type == .tv {
            parameters = ["append_to_response": "similar,recommendations,credits,videos"]
        } else {
            parameters = [:]
        }
        APIService.get(endpoint: "\(type)/\(id)", parameters: parameters) { [weak self] (anyable: OptionalAnyable<Options>) in
            if let media = anyable.wrappedValue as? MediaDetails {
                self?.media = media
            }
        }
    }
}
