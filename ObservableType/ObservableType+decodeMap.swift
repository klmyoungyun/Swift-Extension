import Foundation
import RxSwift

extension ObservableType where Element == (HTTPURLResponse, Data) {
  func decodeMap<T: Decodable>(_ type: T.Type) -> Observable<Result<T, ErrorType>> {
    flatMap { (response: HTTPURLResponse, data: Data) -> Observable<Result<T, ErrorType>> in
      let statusCode = response.statusCode
      let decoder = JSONDecoder()
      switch statusCode {
      case 200..<300:
        do {
          let data = try decoder.decode(T.self, from: data)
          return .just(.success(data))
        } catch {
          return .just(.failure(.undecode))
        }
      case 400: return .just(.failure(.badRequest))
      case 401: return .just(.failure(.unauthorized))
      case 403: return .just(.failure(.forbidden))
      case 404: return .just(.failure(.notFound))
      case 408: return .just(.failure(.requestTimeOut))
      case 409: return .just(.failure(.conflict))
      case 500: return .just(.failure(.internalServerError))
      case 502: return .just(.failure(.badGateway))
      default: return .just(.failure(.otherErrors))
      }
    }
  }
}
