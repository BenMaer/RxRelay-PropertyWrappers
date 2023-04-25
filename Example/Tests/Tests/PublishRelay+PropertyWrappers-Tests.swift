//
//  PublishRelay+PropertyWrappers-Tests.swift
//  RxRelay-PropertyWrappers_Tests
//
//  Created by Benjamin Maer on 4/24/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest

import RxSwift

@testable import RxRelay_PropertyWrappers

final class PublishRelay_PropertyWrappers_Tests: XCTestCase {
    func test_PublishRelayObservableProperty() {
        class Test {
            @PublishRelayObservableProperty var observable: Observable<Bool>
            var observer: AnyObserver<Bool> { _observable.asObserver() }
        }
        
        let test = Test()
        Self.test(observable: test.observable, observer: test.observer)
    }
    
    func test_PublishRelayObserverProperty() {
        class Test {
            @PublishRelayObserverProperty var observer: AnyObserver<Bool>
            var observable: Observable<Bool> { _observer.asObservable() }
        }
        
        let test = Test()
        Self.test(observable: test.observable, observer: test.observer)
    }
}

private extension PublishRelay_PropertyWrappers_Tests {
    static func test(observable: Observable<Bool>, observer: AnyObserver<Bool>, file: StaticString = #filePath, line: UInt = #line) {
        Tests.test(observable: observable, observer: observer, events: .standardEvents, file: file, line: line)
    }
}
