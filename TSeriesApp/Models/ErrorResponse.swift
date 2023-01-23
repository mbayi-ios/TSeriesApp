import Foundation

struct ErrorResponse: Codable {
    let message: String
    let code: Int
    enum CodingKeys: String, CodingKey {
        case message = "status_message", code = "status_code"
    }
}
