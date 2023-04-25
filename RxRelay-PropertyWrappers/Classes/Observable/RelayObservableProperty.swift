//
//  RelayObservableProperty.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxSwift

@propertyWrapper
struct RelayObservableProperty<Relay: RelayPropertyType & HasBlankInit> {
    typealias Element = Relay.Element
    let relay = Relay()
    var wrappedValue: Observable<Element> { relay.asObservable() }
}

extension RelayObservableProperty: ObserverType {
    func on(_ event: RxSwift.Event<Element>) { relay.on(event) }
}
