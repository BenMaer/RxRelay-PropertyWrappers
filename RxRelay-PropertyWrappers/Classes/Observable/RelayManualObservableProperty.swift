//
//  RelayManualObservableProperty.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxSwift

@propertyWrapper
struct RelayManualObservableProperty<Relay: RelayPropertyType> {
    typealias Element = Relay.Element
    let relay: Relay
    var wrappedValue: Observable<Element> { relay.asObservable() }
}

extension RelayManualObservableProperty {
    typealias RelayType = Relay
}

extension RelayManualObservableProperty: ObserverType {
    func on(_ event: RxSwift.Event<Element>) { relay.on(event) }
}
