//
//  RelayManualObserverProperty.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxSwift

@propertyWrapper
struct RelayManualObserverProperty<Relay: RelayPropertyType> {
    typealias Element = Relay.Element
    let relay: Relay
    var wrappedValue: AnyObserver<Element> { relay.asObserver() }
}

extension RelayManualObserverProperty: ObservableType {
    func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Relay.Element == Observer.Element { relay.subscribe(observer) }
}
