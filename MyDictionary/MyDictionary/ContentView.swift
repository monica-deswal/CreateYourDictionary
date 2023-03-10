//
//  ContentView.swift
//  MyDictionary
//
//  Created by Monica Deshwal on 07/01/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    let dictionaryViewModel = DictionaryViewModel()
    @State var type = ""
    @State var meaning = ""
    @State var sentense = ""
    
    @State var shouldHide = false

    @State private var opacity: Double = 1
    @State var dictWord: DictWord?
    
    var body: some View {
        
        ZStack {
            Image("background-image3")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Learn the word")
                    .font(.title)
                    .padding([.top], -40)
                Spacer()
                Spacer()
                
                VStack(spacing: 10) {
                    Text((self.dictWord?.word ?? "").uppercased())
                        .opacity(opacity)
                        .font(.largeTitle)
                        .padding(5)
                    
                    if !shouldHide {
                        
                        Button("Show The Answer") {
                            withAnimation(.linear(duration: 0.45), {
                                type = dictWord?.usageType ?? ""
                                meaning = dictWord?.meaning ?? ""
                                sentense = dictWord?.sentense ?? ""
                            })
                            shouldHide = true
                        }.font(.title2)
                            .background(Color(red: 227/255
                                              , green: 239/255
                                              , blue: 205/255))
                            .foregroundColor(Color.black)
                            .padding([.top], 180)
                    }
                    
                    Text(self.type)
                        .opacity(opacity)
                        .font(.body)
                    
                    Text(self.meaning)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 36/255
                                               , green: 55/255
                                               , blue: 99/255))
                        .opacity(opacity)
                        .font(.title2)
                        .padding([.leading, .trailing], 80)
                    
                    Text(self.sentense)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 60/255
                                               , green: 98/255
                                               , blue: 85/255))
                        .opacity(opacity)
                        .font(.title2)
                        .padding([.leading, .trailing], 80)
                }.padding([.leading, .trailing], 15)
                Spacer()
                HStack(spacing: 45) {
                    
                    Button("Move to Next ") {
                        withAnimation(.easeInOut(duration: 0.5), {
                            type = ""
                            meaning = ""
                            sentense = ""
                            self.opacity = 0
                        })
                        
                        self.shouldHide = false
                        dictionaryViewModel.updateTheObserver()
                        
                        withAnimation(.easeInOut(duration: 1), {
                            self.opacity = 1
                        })
                    }.font(.title2)
                        .foregroundColor(Color.black)
                }.padding(.bottom, 0)
            }.padding([.leading, .trailing], 15)
        }.padding(40)
            .onReceive(dictionaryViewModel.dictWordSubject.publisher) { dictWordValue in
                dictWord = dictWordValue
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension UIImage {
    
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
