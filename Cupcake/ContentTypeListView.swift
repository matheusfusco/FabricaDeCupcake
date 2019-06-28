//
//  ContentTypeListView.swift
//  Cupcake
//
//  Created by Matheus Pacheco Fusco on 28/06/19.
//  Copyright © 2019 Matheus Pacheco Fusco. All rights reserved.
//

import SwiftUI

let types: [String] = ["Tipo 1", "Tipo 2"]

struct ContentTypeListView : View {
    var body: some View {
        NavigationView {
            List() {
                Section(header: Text("Teste grouped")) {
                    ForEach(0 ..< types.count) { index in
                        if index == 0 {
                            NavigationButton(destination: ContentView()) {
                                Text("\(types[index])")
                            }
                        } else {
                            NavigationButton(destination: NewContentView()) {
                                Text("\(types[index])")
                            }
                        }
                    }
                }
            }.listStyle(.grouped)
            List() {
                Section(header: Text("Teste sem grouped")) {
                    ForEach(0 ..< types.count) { index in
                        if index == 0 {
                            NavigationButton(destination: ContentView()) {
                                Text("\(types[index])")
                            }
                        } else {
                            NavigationButton(destination: NewContentView()) {
                                Text("\(types[index])")
                            }
                        }
                    }
                }
            }.listStyle(.plain)
            .navigationBarTitle(Text("Fábrica de Cupcakes"))
            Spacer()
        }
    }
}

#if DEBUG
struct ContentTypeListView_Previews : PreviewProvider {
    static var previews: some View {
        ContentTypeListView()
    }
}
#endif
