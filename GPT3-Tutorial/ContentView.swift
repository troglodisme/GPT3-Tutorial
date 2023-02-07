//
//  ContentView.swift
//  GPT3-Tutorial
//
//  Created by Giulio on 07/02/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var generatorVM = GeneratorViewModel()
    
    var body: some View {
        
        NavigationStack {
         
            VStack(alignment: .leading) {
                
                VStack{
                    Text(generatorVM.message)
                }
                .padding()
                
                Button {
                    
                    Task {
                        await generatorVM.generatePoem()
                    }
                    
                } label: {
                    Text("Generate Poem")
                }
                
            }
            .padding()
            .navigationTitle("AI Poet")
        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



