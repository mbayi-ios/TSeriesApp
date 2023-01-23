import Foundation
import Alamofire

final class APIService {
    private static let API_KEY = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    private static let BASE_URL = "https://api.themoviedb.org/3/"

    static func get<T: Codable>(endpoint: String, parameters: [String: Any] = [:], callback: @escaping (T) -> Void) {
        var params = parameters
        params["api_key"] = API_KEY
        AF.request(BASE_URL + endpoint, method: .get, parameters: params).responseDecodable(of: T.self, queue: .main) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }

    static func post<T: Codable, Body: Encodable>(endpoint: String, body: Body?, callback: @escaping (T) -> Void, errorCallback: ((ErrorResponse?) -> Void)? = nil) {
        AF.request("\(BASE_URL)\(endpoint)?api_key=\(API_KEY)", method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type":"application/json"]).validate().responseDecodable(of: T.self) { result in
            if let _ = result.error {
                if let data = result.data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    errorCallback?(errorResponse)
                    return
                }
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }

    static func delete<T: Codable, Body: Encodable>(endpoint: String, body: Body?, callback: @escaping (T) -> Void) {
        AF.request("\(BASE_URL)\(endpoint)?api_key=\(API_KEY)", method: .delete, parameters: body, encoder: JSONParameterEncoder.default, headers: ["Content-Type":"application/json"]).responseDecodable(of: T.self) { result in
            if let error = result.error {
                print(error.localizedDescription)
                return
            }
            if let value = result.value {
                callback(value)
            } else {
                print("[Error]: Missing value.")
            }
        }
    }
}
