//
//  NewOrder.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 24/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI
import Combine

class Cupcake: BindableObject, Equatable {
    var didChange = PassthroughSubject<Cupcake, Never>()
    
    static let flavours = ["Baunilha", "Chocolate", "Morango", "Arco-íris"]
    var type = 0 { didSet { update() } }
    var quantity = 1 { didSet { update() } }
    
    var specialRequestEnabled = false { didSet { update() } }
    var extraFrosting = false { didSet { update() } }
    var addSprinkles = false { didSet { update() } }
    
    internal func update() {
        didChange.send(self)
    }
    
    static func ==(lhs: Cupcake, rhs: Cupcake) -> Bool {
        return lhs.type == rhs.type && lhs.specialRequestEnabled == rhs.specialRequestEnabled && lhs.extraFrosting == rhs.extraFrosting && lhs.addSprinkles == rhs.addSprinkles
    }
}

final class NewOrder: BindableObject {
    var didChange = PassthroughSubject<NewOrder, Never>()
    
    //section 1
    var cupcake = [Cupcake]() { didSet { update() }}
    
    //section 2
    var name = "" { didSet { update() } }
    var streetAddress = "" { didSet { update() } }
    var city = "" { didSet { update() } }
    var zipCode = "" { didSet { update() } }
    
    var isValid: Bool {
        if cupcake.count == 0 || name.isEmpty || streetAddress.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        return true
    }
    
    internal func update() {
        didChange.send(self)
    }
}
