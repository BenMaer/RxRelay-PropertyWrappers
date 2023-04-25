//
//  ReplayRelay+PropertyWrappers.swift
//  RxRelay-PropertyWrappers
//
//  Created by Benjamin Maer on 4/24/23.
//

import Foundation

import RxRelay

extension ReplayRelay: RxRelayType, RelayPropertyType {}
typealias ReplayRelayObservableProperty<Element> = RelayManualObservableProperty<ReplayRelay<Element>>
typealias ReplayRelayObserverProperty<Element> = RelayManualObserverProperty<ReplayRelay<Element>>
