//
//  EmotionPicker.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//
import SwiftUI

struct EmotionDropdown: View {
    /////////////////////////////////////////////////////////
    // Com o @EnvironmentObject você declara uma variável que receberá um objeto observável do tipo declarado 'KeyModel'
    @EnvironmentObject var key: KeyModel
    /////////////////////////////////////////////////////////
    
    @State private var isExpanded = false
    
    let emotions = [
        "Nenhuma emoção",
        "Alegria",
        "Tensão",
        "Tristeza"
    ]
    
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        //@Bindable var viewModel = viewModel
        
        Button(action: {
            isExpanded.toggle()
        }) {
            
            HStack {
                
                Text(key.sentimentoSelecionado)
                    .foregroundColor(.black)
                    .font(isIpad ? .title2 : .default)
                    .fontWeight(isIpad ? .semibold : .regular)

                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .rotationEffect(
                        .degrees(isExpanded ? 180 : 0)
                    )
            }
            .padding(isIpad ? 18 : 12)
            .background(Color("ColorSecondary"))
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .overlay(alignment: .topLeading) {
            
            if isExpanded {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(emotions, id: \.self) { emotion in
                        
                        Button(action: {
                            
                           key.escolherSentimento(add: emotion)
                            //selectedEmotion = emotion
                            isExpanded = false
                            
                        }) {
                            
                            HStack {
                                
                                Text(emotion)
                                    .foregroundColor(.black)
                                    .font(isIpad ? .title2 : .body)
                                    .fontWeight(isIpad ? .semibold : .regular)
                                
                                Spacer()
                                
                                if key.sentimentoSelecionado == emotion {
                                    
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("ColorPrimary"))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(isIpad ? 10 : 10)
                            .background(
                                key.sentimentoSelecionado == emotion
                                ? Color("ColorPrimary").opacity(0.25)
                                : Color("ColorSecondary").opacity(1)
                            )
                        }
                        
                        Divider()
                    }
                }
                .background(Color("ColorSecondary"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
                .zIndex(1)
            }
        }
    }
}

#Preview {
    EmotionDropdown()
    /////////////////////////////////////////////////////////
    // Passa o .environmentObject(Object()) para que o preview não crashe e saiba qual tipo de objeto ele está olhando
        .environmentObject(KeyModel())
    /////////////////////////////////////////////////////////
}

