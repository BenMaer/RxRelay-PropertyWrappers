//
//  RxRelayType.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxRelay
import RxSwift

protocol RxRelayType: ObserverType, ObservableType {
    associatedtype Element
    func accept(_ event: Element)
}

extension RxRelayType /** RxRelayType: ObserverType */ {
    public func on(_ event: RxSwift.Event<Element>) {
        switch event {
        case let .next(element):    accept(element)
        case let .error(error):     assertionFailure("RxRelay's should never receive an error, but did: \(error)")
        case .completed:            break
        }
    }
}
