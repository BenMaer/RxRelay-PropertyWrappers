//
//  Tests.swift
//  RxRelay-PropertyWrappers_Tests
//
//  Created by Benjamin Maer on 4/24/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

import RxSwift

enum Tests {}

extension Tests {
    enum Event<T: Equatable>: Equatable {
        case fire(T)
        case didFire(T)
    }
    
    static func test<T: Equatable>(observable: Observable<T>, observer: AnyObserver<T>, events: [Event<T>], file: StaticString = #filePath, line: UInt = #line) {
        let disposeBag = DisposeBag()
        var eventsRemaining = Array(events.reversed())
        
        let eventFired: (Event) -> Void = { event in
            guard let nextEvent = eventsRemaining.popLast() else {
                XCTAssert(false, "observable did fire, but no events left")
                return
            }
            
            XCTAssert(nextEvent == event, "event fired: \(event)\nbut expected next event: \(nextEvent)", file: file, line: line)
        }
        
        observable
            .subscribe(onNext: { eventFired(.didFire($0)) })
            .disposed(by: disposeBag)
        
        while let nextStep = eventsRemaining.popLast() {
            guard case let .fire(value) = nextStep else {
                XCTAssert(false, "should have encountered fire event, instead received: \(nextStep)\n. Probably didn't get to fire off an expected `didFire` event.", file: file, line: line)
                return
            }
            
            observer.onNext(value)
        }
    }
}

extension Array where Element == Tests.Event<Bool> {
    static var standardBoolEvents: Self {[
        .fire(true),
        .didFire(true),
        .fire(false),
        .didFire(false),
        .fire(false),
        .didFire(false),
        .fire(true),
        .didFire(true),
    ]}
}
