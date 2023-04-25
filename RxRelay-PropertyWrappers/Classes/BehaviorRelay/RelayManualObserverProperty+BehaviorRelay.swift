//
//  RelayManualObserverProperty+BehaviorRelay.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxRelay

// Useful when using instances of `BehaviorRelayObserverProperty`, since the underlying property must be manually init'ed.
extension RelayManualObserverProperty {
    init<Element>(value: Element) where Relay == BehaviorRelay<Element> {
        self.init(relay: .init(value: value))
    }
}
