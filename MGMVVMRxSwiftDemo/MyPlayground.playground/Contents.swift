//: Playground - noun: a place where people can play

import UIKit
import RxSwift

// 1
enum MyError: Error {
    case anError
}
// 2
func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

let disposeBag = DisposeBag()

print("==== Start ====")






