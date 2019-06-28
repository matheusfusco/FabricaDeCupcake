//
//  CupcakeRow.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 25/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI

struct CupcakeRow : View {
    var cupcake: Cupcake
    
    var body: some View {
        HStack {
            Text(Cupcake.flavours[cupcake.type])
            Text("-")
            Text("Gran.: " + (cupcake.addSprinkles ? "SIM" : "NÃO"))
            Text("-")
            Text("Cob. Ex.: " + (cupcake.extraFrosting ? "SIM" : "NÃO"))
            Text("-")
            Text("Qt: \((cupcake.quantity))")
        }
    }
}

#if DEBUG
struct CupcakeRow_Previews : PreviewProvider {
    static var previews: some View {
        CupcakeRow(cupcake: Cupcake())
    }
}
#endif
