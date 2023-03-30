import Foundation

class NetworkHelper {
  private let riddleUrl = "https://api.api-ninjas.com/v1/riddles?limit=20"
  var riddles: Riddles?
    static let shared = NetworkHelper()
    func getRiddles(completion: @escaping (Riddles?) -> Void) {
        guard let url = URL(string: riddleUrl) else {
            completion(nil)
            return
        }

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                return
            }

            do {
                let riddleResponse = try JSONDecoder().decode(Riddles.self, from: data)
                completion(riddleResponse)
            } catch _ {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func getJokes(completion: @escaping (Jokes?) -> Void) {
        let url = URL(string: "https://api.api-ninjas.com/v1/jokes?limit=3")!
        var request = URLRequest(url: url)
        request.setValue("x6V7ICAl9ju0nwmUILahYQ==zeqg81n5TMtQHprr", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let jokesResponse = try JSONDecoder().decode(Jokes.self, from: data)
                completion(jokesResponse)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
