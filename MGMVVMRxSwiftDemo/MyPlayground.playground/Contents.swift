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

struct Student {
    var score: Variable<Int>
}

var score = Variable<Int>(1)
var score2 = Variable<Int>(2)

// 1
let ryan = Student(score: Variable(80))
let charlotte = Student(score: Variable(90))
// 2
let student = PublishSubject<Student>()
// 3
student.asObservable()
    .flatMap {
        $0.score.asObservable()
    }
    // 4
    .subscribe(onNext: {
        print($0)
    })
    .addDisposableTo(disposeBag)

student.onNext(ryan)
ryan.score.value = 85

Observable
    .combineLatest(score.asObservable(), score2.asObservable())
    .subscribe( onNext: { s1, s2 in
        print(s1, s2)
    })

score.value = 3

