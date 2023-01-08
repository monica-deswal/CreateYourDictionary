//
//  ContentView.swift
//  MyDictionary
//
//  Created by Monica Deshwal on 07/01/23.
//

import SwiftUI

struct ContentView: View {
    
    let dictionaryViewModel = DictionaryViewModel()
    
    @State var word = ""
    @State var type = ""
    @State var meaning = ""
    @State var sentense = ""
    
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(self.word)
                .font(.title)
            
            Text(self.type)
                .font(.title)
            
            Text(self.meaning)
                .font(.title)
            
            Spacer()
            Spacer()
            HStack{
                
                Button("Show The Answer") {
                    
                }.padding(12)
                    .font(.body)
                    .foregroundColor(Color.green)
                
                Spacer()
                Button("Move to Next ") {
                    word = "111"
                    type = "2222"
                    meaning = "3333"
                    sentense = "4444"
                }.padding(12)
                    .font(.body)
                    .foregroundColor(Color.green)
                
                
            }
            Spacer()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
