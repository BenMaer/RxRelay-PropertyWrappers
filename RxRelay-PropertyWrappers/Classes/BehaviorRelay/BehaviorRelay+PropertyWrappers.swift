//
//  BehaviorRelay+PropertyWrappers.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxRelay

extension BehaviorRelay: RxRelayType, RelayPropertyType {}
typealias BehaviorRelayObservableProperty<Element> = RelayManualObservableProperty<BehaviorRelay<Element>>
typealias BehaviorRelayObserverProperty<Element> = RelayManualObserverProperty<BehaviorRelay<Element>>

extension OptionalBehaviorRelay: RelayPropertyType, HasBlankInit {}
typealias OptionalBehaviorRelayObservableProperty<Element> = RelayObservableProperty<OptionalBehaviorRelay<Element>>
typealias OptionalBehaviorRelayObserverProperty<Element> = RelayObserverProperty<OptionalBehaviorRelay<Element>>
