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

print("==== Start ====")

let disposeBag = DisposeBag()

let source = Observable.of(1, 3, 5, 7, 9)

let observable = source.scan((0,0)) { acc, current -> (Int, Int) in
    return (current, acc.1 + current)
}

observable
    .subscribe(onNext: { (origin, sum) in
    print(origin, sum)
}).disposed(by: disposeBag)
