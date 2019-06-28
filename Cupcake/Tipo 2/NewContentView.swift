//
//  NewContentView.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 24/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI
import UIKit

struct NewContentView : View {
    @ObjectBinding var order = NewOrder()
    @ObjectBinding var cupcake = Cupcake()
    @State var confirmationMessage = ""
    @State var showingConfirmationAlert = false
    @State var showingActionSheet = false
    @State var showingEditAlert = false
    
    var sheet: ActionSheet {
        ActionSheet(title: Text("O que deseja fazer?"),
                    message: nil,
                    buttons: [.default(Text("Editar"), onTrigger: {
                                self.showingActionSheet = false
                                self.showingEditAlert = true
                              }),
                              .default(Text("Excluir"), onTrigger: {
                                self.showingActionSheet = false
                              }),
                              .destructive(Text("Cancelar"))]
                    )
    }
    
    var body: some View {
//        return NavigationView {
            return Form {
                Text("Nesse exemplo, você consegue efetuar o pedido de quantos cupcakes quiser. A medida que adicionar a lista, ela é atualizada e exibida. O Botão de 'Efetuar Pedido' só libera quando o usuário preenche todos os dados do pedido.")
                    .lineLimit(nil)
                Section {
                    Picker(selection: $cupcake.type, label: Text("Selecione o tipo de Cupcake")) {
                        ForEach(0 ..< Cupcake.flavours.count) {
                            Text(Cupcake.flavours[$0])
                        }
                    }

                    Stepper(value: $cupcake.quantity, in: 1...20) {
                        Text("Quantidade: \(cupcake.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $cupcake.specialRequestEnabled) {
                        Text("Algum requerimento especial?")
                    }

                    if cupcake.specialRequestEnabled {
                        Toggle(isOn: $cupcake.extraFrosting) {
                            Text("Adicionar cobertura extra")
                        }

                        Toggle(isOn: $cupcake.addSprinkles) {
                            Text("Adicionar granulado")
                        }
                    }
                }

                Section {
                    Button(action: {
                        self.addToCart(self.cupcake)
                    }) {
                        Text("Adicionar ao Carrinho")
                    }
                }

                if order.cupcake.count > 0 {
                    Section {
                        ForEach(order.cupcake) { cup in
                            VStack {
                                HStack {
                                    Text(Cupcake.flavours[cup.type])
                                    Spacer()
                                    Text("Qt: \((cup.quantity))")
                                }
                                HStack {
                                    Text("Granulado: " + (cup.addSprinkles ? "SIM" : "NÃO"))
                                    Spacer()
                                    Text("Cobertura Extra: " + (cup.extraFrosting ? "SIM" : "NÃO"))
                                }
                            }.gesture(
                                LongPressGesture(minimumDuration: 1)
                                    .onEnded { _ in
                                        self.showingActionSheet = true
                                    }
                            )
                        }
                    }
                }
            
                Section {
                    TextField($order.name, placeholder: Text("Nome"))
                    TextField($order.streetAddress, placeholder: Text("Endereço"))
                    TextField($order.city, placeholder: Text("Cidade"))
                    TextField($order.zipCode, placeholder: Text("CEP"))
                }

                Section {
                    Button(action: {
                        self.placeOrder()
                    }) {
                        Text("Efetuar pedido")
                    }
                }.disabled(!order.isValid)
            }
            .navigationBarTitle(Text("Fábrica 2"))
            .presentation($showingConfirmationAlert) {
                Alert(title: Text("Obrigado!"), message: nil, dismissButton: .default(Text("Ok"), onTrigger: {
                    self.resetOrder()
                }))
            }
            .presentation(showingActionSheet ? sheet : nil)
//        }
    }
    
    func removeFromCart(_ cupcake: Cupcake) {
        
    }
    
    func addToCart(_ cupcake: Cupcake) {
        let cup = Cupcake()
        cup.type = cupcake.type
        cup.addSprinkles = cupcake.addSprinkles
        cup.extraFrosting = cupcake.extraFrosting
        cup.quantity = cupcake.quantity
        if let c = order.cupcake.filter({ $0 == cup }).first {
            c.quantity += cupcake.quantity
        } else {
            order.cupcake.append(cup)
        }
        resetCupcake()
    }
    
    func resetCupcake() {
        cupcake.addSprinkles = false
        cupcake.extraFrosting = false
        cupcake.specialRequestEnabled = false
        cupcake.quantity = 1
        cupcake.type = 0
    }
    
    func resetOrder() {
        order.city = ""
        order.zipCode = ""
        order.name = ""
        order.streetAddress = ""
        order.cupcake.removeAll()
    }
    
    func placeOrder() {
        showingConfirmationAlert = true
    }
}

#if DEBUG
struct NewContentView_Previews : PreviewProvider {
    static var previews: some View {
        NewContentView()
    }
}
#endif
