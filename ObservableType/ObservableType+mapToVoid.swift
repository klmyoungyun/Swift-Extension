import Foundation

import RxCocoa
import RxSwift

extension ObservableType where Element == Bool {
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}
