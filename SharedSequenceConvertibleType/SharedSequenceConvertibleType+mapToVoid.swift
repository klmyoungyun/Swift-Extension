import Foundation

import RxCocoa
import RxSwift

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}
