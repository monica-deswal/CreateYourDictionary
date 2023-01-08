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
    
    @State var wordModel: DictWord?
    
    @State private var opacity: Double = 1
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Text("Learn the word")
                    .font(.title)
                    .padding([.top, .bottom], 50)
                
                VStack(spacing: 10) {
                    Text(self.word.uppercased())
                        .opacity(opacity)
                        .font(.largeTitle)
                        .padding(5)
                    
                    Text(self.type)
                        .opacity(opacity)
                        .font(.body)
                    
                    Text(self.meaning)
                        .multilineTextAlignment(.center)
                        .opacity(opacity)
                        .font(.title)
                        .padding(10)
                    
                    Text(self.sentense)
                        .multilineTextAlignment(.center)
                        .opacity(opacity)
                        .font(.title)
                        .padding([.leading, .trailing], 5)
                        .padding([.bottom], 10)
                }.background(Color.purple)
                    .cornerRadius(20)
                
                Spacer()
                HStack {
                    
                    Button("Show The Answer") {
                        
                        
                        withAnimation(.linear(duration: 0.45), {
                            type = wordModel?.usageType ?? ""
                            meaning = wordModel?.meaning ?? ""
                            sentense = wordModel?.sentense ?? ""
                            })
                        
                    }.padding(5)
                        
                        .font(.title3)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    Button("Move to Next ") {
                        withAnimation(.easeInOut(duration: 0.5), {
                            self.opacity = 0
                        })
                        
                        self.wordModel = self.dictionaryViewModel.generateTherandomElement()
                        
                        withAnimation(.easeInOut(duration: 1), {
                            word = wordModel?.word ?? ""
                            type = ""
                            meaning = ""
                            sentense = ""
                            self.opacity = 1
                        })
                        
                    }.padding(5)
                        .font(.title3)
                        .foregroundColor(Color.black)
                }
            }
        }.padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
