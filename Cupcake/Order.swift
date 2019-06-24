//
//  Order.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 24/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI
import Combine

final class Order: BindableObject, Codable {
    enum CodingKeys: String, CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zipCode
    }
    
    var didChange = PassthroughSubject<Void, Never>()
    
    static let types = ["Baunilha", "Chocolate", "Morango", "Arco-íris"]
    
    //section 1
    var type = 0 { didSet { update() } }
    var quantity = 1 { didSet { update() } }
    
    //section 2
    var specialRequestEnabled = false { didSet { update() } }
    var extraFrosting = false { didSet { update() } }
    var addSprinkles = false { didSet { update() } }
    
    //section 3
    var name = "" { didSet { update() } }
    var streetAddress = "" { didSet { update() } }
    var city = "" { didSet { update() } }
    var zipCode = "" { didSet { update() } }
    
    var isValid: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zipCode.isEmpty {
            return false
        }
        return true
    }
    
    internal func update() {
        didChange.send()
    }
}
