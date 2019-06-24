//
//  ContentView.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 24/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var order = Order()
    @State var confirmationMessage = ""
    @State var showingConfirmationAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $order.type, label: Text("Selecione o tipo de Cupcake")) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.quantity, in: 1...20) {
                        Text("Quantidade: \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled) {
                        Text("Algum requerimento especial?")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Adicionar cobertura extra")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Adicionar granulado")
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
            .navigationBarTitle(Text("Fábrica de Cupcakes"))
            .presentation($showingConfirmationAlert) {
                Alert(title: Text("Obrigado!"), message: Text(confirmationMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func placeOrder() {
        do {
            let encodedOrder = try JSONEncoder().encode(order)
            guard let url = URL(string: "https://reqres.in/api/cupcakes") else { return }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encodedOrder
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    print("Sem resposta na chamada: \(error?.localizedDescription ?? "Erro desconhecido").")
                    return
                }
                
                do {
                    let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                    self.confirmationMessage = "Seu pedido de \(decodedOrder.quantity) cupcakes de \(Order.types[decodedOrder.type]) está a caminho!"
                    self.showingConfirmationAlert  = true
                } catch {
                    let dataString = String(decoding: data, as: UTF8.self)
                    print("Resposta inválida: \(dataString)")
                }
            }.resume()
        } catch {
            print("Erro ao converter objeto.")
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
