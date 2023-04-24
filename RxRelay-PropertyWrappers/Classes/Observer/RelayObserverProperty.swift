//
//  RelayObserverProperty.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxSwift

@propertyWrapper
struct RelayObserverProperty<Relay: RelayPropertyType & HasBlankInit> {
    typealias Element = Relay.Element
    let relay = Relay()
    var wrappedValue: AnyObserver<Element> { relay.asObserver() }
}

extension RelayObserverProperty: ObservableType {
    func subscribe<Observer>(_ observer: Observer) -> Disposable where Observer : ObserverType, Relay.Element == Observer.Element { relay.subscribe(observer) }
}
