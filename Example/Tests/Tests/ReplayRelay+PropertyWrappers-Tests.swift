//
//  ReplayRelay+PropertyWrappers-Tests.swift
//  RxRelay-PropertyWrappers_Tests
//
//  Created by Benjamin Maer on 4/24/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest

import RxSwift

@testable import RxRelay_PropertyWrappers

private protocol TestType {
    var observable: Observable<Int> { get }
    var observer: AnyObserver<Int> { get }
    init(bufferSize: Int)
}

final class ReplayRelay_PropertyWrappers_Tests: XCTestCase {
    func test_ReplayRelayObservableProperty() {
        class Test: TestType {
            @ReplayRelayObservableProperty var observable: Observable<Int>
            var observer: AnyObserver<Int> { _observable.asObserver() }
            required init(bufferSize: Int) {
                _observable = .init(relay: .create(bufferSize: bufferSize))
            }
        }
        
        Self.test(Test.self)
    }
    
    func test_ReplayRelayObserverProperty() {
        class Test: TestType {
            @ReplayRelayObserverProperty var observer: AnyObserver<Int>
            var observable: Observable<Int> { _observer.asObservable() }
            required init(bufferSize: Int) {
                _observer = .init(relay: .create(bufferSize: bufferSize))
            }
        }
        
        Self.test(Test.self)
    }
}

private extension ReplayRelay_PropertyWrappers_Tests {
    struct TestEnvironment {
        let size: Int
        let ints: [Int]
        let expected: [Int]
    }
    
    static func test<T: TestType>(_ type: T.Type, environments: [TestEnvironment] = .standardEnvironments, file: StaticString = #filePath, line: UInt = #line) {
        environments.forEach { environment in
            let test = T.init(bufferSize: environment.size)
            environment.ints.forEach { test.observer.onNext($0) }
            Self.test(observable: test.observable, observer: test.observer, initialEvents: environment.expected.map({ .didFire($0) }), file: file, line: line)
        }
    }
    
    static func test(observable: Observable<Int>, observer: AnyObserver<Int>, initialEvents: [Tests.Event<Int>], file: StaticString = #filePath, line: UInt = #line) {
        Tests.test(
            observable: observable,
            observer: observer,
            events: [
                initialEvents,
                (95...105).flatMap({ [.fire($0), .didFire($0)] }),
            ].flatMap({ $0 }),
            file: file,
            line: line
        )
    }
}

private extension Array where Element == ReplayRelay_PropertyWrappers_Tests.TestEnvironment {
    static var standardEnvironments: Self {[
        .init(size: 3, ints: [1, 2, 3], expected: [1, 2, 3]),
        .init(size: 2, ints: [1, 2, 3], expected: [2, 3]),
        .init(size: 1, ints: [1, 2, 3], expected: [3]),
        .init(size: 55, ints: [1, 2, 3], expected: [1, 2, 3]),
    ]}
}
