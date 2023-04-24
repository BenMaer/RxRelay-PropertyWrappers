//
//  OptionalBehaviorRelay.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxRelay
import RxSwift

final class OptionalBehaviorRelay<OElement> {
    typealias Element = OElement?
    private let relay = BehaviorRelay<Element>()
    var value: Element { relay.value }
}

extension OptionalBehaviorRelay: ObservableType {
    func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Element == Observer.Element { relay.subscribe(observer) }
}

extension OptionalBehaviorRelay: ObserverType {
    func on(_ event: RxSwift.Event<Element>) { relay.on(event) }
}
