//
//  BehaviorRelay+PropertyWrappers-Tests.swift
//  RxRelay-PropertyWrappers_Tests
//
//  Created by Benjamin Maer on 4/24/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest

import RxSwift

@testable import RxRelay_PropertyWrappers

final class BehaviorRelay_PropertyWrappers_Tests: XCTestCase {
    func test_BehaviorRelayObservableProperty() {
        class Test {
            @BehaviorRelayObservableProperty var observable: Observable<Bool>
            var observer: AnyObserver<Bool> { _observable.asObserver() }
            init(_ bool: Bool) {
                _observable = .init(value: bool)
            }
        }
        
        for bool in [true, false] {
            let test = Test(bool)
            Self.test(observable: test.observable, observer: test.observer, initialValue: bool)
        }
    }
    
    func test_BehaviorRelayObserverProperty() {
        class Test {
            @BehaviorRelayObserverProperty var observer: AnyObserver<Bool>
            var observable: Observable<Bool> { _observer.asObservable() }
            init(_ bool: Bool) {
                _observer = .init(value: bool)
            }
        }
        
        for bool in [true, false] {
            let test = Test(bool)
            Self.test(observable: test.observable, observer: test.observer, initialValue: bool)
        }
    }
}

private extension BehaviorRelay_PropertyWrappers_Tests {
    static func test(observable: Observable<Bool>, observer: AnyObserver<Bool>, initialValue: Bool, file: StaticString = #filePath, line: UInt = #line) {
        Tests.test(
            observable: observable,
            observer: observer,
            events: [
                [.didFire(initialValue)],
                .standardBoolEvents,
            ].flatMap({ $0 }),
            file: file,
            line: line
        )
    }
}
