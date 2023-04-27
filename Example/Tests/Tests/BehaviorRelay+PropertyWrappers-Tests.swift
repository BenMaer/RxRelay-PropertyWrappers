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
    func test_BehaviorRelayManualObserverProperty() {
        class Test {
            @BehaviorRelayManualObserverProperty var observer: AnyObserver<Bool>
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
    
    func test_BehaviorRelayManualObservableProperty() {
        class Test {
            @BehaviorRelayManualObservableProperty var observable: Observable<Bool>
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
            @BehaviorRelayObserverProperty var observer: AnyObserver<BoolDictionary>
            var observable: Observable<BoolDictionary> { _observer.asObservable() }
        }
        
        let test = Test()
        Self.test(observable: test.observable, observer: test.observer)
    }
    
    func test_BehaviorRelayObservableProperty() {
        class Test {
            @BehaviorRelayObservableProperty var observable: Observable<BoolDictionary>
            var observer: AnyObserver<BoolDictionary> { _observable.asObserver() }
        }
        
        let test = Test()
        Self.test(observable: test.observable, observer: test.observer)
    }
}

private extension BehaviorRelay_PropertyWrappers_Tests {
    static func test(observable: Observable<Bool>, observer: AnyObserver<Bool>, initialValue: Bool, file: StaticString = #filePath, line: UInt = #line) {
        test(observable: observable, observer: observer, initialValue: initialValue, extraEvents: .standardBoolEvents, file: file, line: line)
    }
    
    typealias BoolDictionary = [Bool: Bool]
    static func test(observable: Observable<BoolDictionary>, observer: AnyObserver<BoolDictionary>, file: StaticString = #filePath, line: UInt = #line) {
        test(observable: observable, observer: observer, initialValue: .init(), extraEvents: .standardBoolDictionaryEvents, file: file, line: line)
    }
    
    static func test<T: Equatable>(observable: Observable<T>, observer: AnyObserver<T>, initialValue: T, extraEvents: [Tests.Event<T>], file: StaticString = #filePath, line: UInt = #line) {
        Tests.test(
            observable: observable,
            observer: observer,
            events: [
                [.didFire(initialValue)],
                extraEvents,
            ].flatMap({ $0 }),
            file: file,
            line: line
        )
    }
}

extension Dictionary: HasBlankInit {}

extension Array where Element == Tests.Event<BehaviorRelay_PropertyWrappers_Tests.BoolDictionary> {
    static var standardBoolDictionaryEvents: Self {[
        .fire([true: true]),
        .didFire([true: true]),
        .fire([true: false]),
        .didFire([true: false]),
        .fire([false: true]),
        .didFire([false: true]),
        .fire([false: false]),
        .didFire([false: false]),
    ]}
}
