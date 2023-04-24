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
            @PublishRelayObservableProperty var observable: Observable<Void>
            var observer: AnyObserver<Void> { _observable.asObserver() }
        }
        
        let test = Test()
        self.test(observable: test.observable, observer: test.observer)
    }
    
    func test_PublishRelayObserverProperty() {
        class Test {
            @PublishRelayObserverProperty var observer: AnyObserver<Void>
            var observable: Observable<Void> { _observer.asObservable() }
        }
        
        let test = Test()
        self.test(observable: test.observable, observer: test.observer)
    }
    
    private let disposeBag = DisposeBag()
}

private extension PublishRelay_PropertyWrappers_Tests {
    func test(observable: Observable<Void>, observer: AnyObserver<Void>) {
        var observableHasFired: Bool = false
        
        observable
            .subscribe(onNext: { _ in observableHasFired = true })
            .disposed(by: disposeBag)
        
        XCTAssert(observableHasFired == false, "Should not have fired yet.")
        
        observer.onNext(())
        
        XCTAssert(observableHasFired == true, "Should have fired.")
    }
}
