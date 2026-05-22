//
//  EmotionPicker.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//
import SwiftUI

struct EmotionDropdown: View {
    @State private var viewModel = CarouselViewModel()
    //@State private var selectedEmotion = "Nenhuma emoção escolhida"
    @State private var isExpanded = false
    
    let emotions = [
        "Nenhuma emoção",
        "Alegria",
        "Tensão",
        "Tristeza"
    ]
    
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        
        Button(action: {
            isExpanded.toggle()
        }) {
            
            HStack {
                
                Text(viewModel.sentimentoSelecionado)
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
            .clipShape(RoundedRectangle(cornerRadius: 40))
        }
        .overlay(alignment: .topLeading) {
            
            if isExpanded {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(emotions, id: \.self) { emotion in
                        
                        Button(action: {
                            
                           viewModel.escolherSentimento(add: emotion)
                            //selectedEmotion = emotion
                            isExpanded = false
                            
                        }) {
                            
                            HStack {
                                
                                Text(emotion)
                                    .foregroundColor(.black)
                                    .font(isIpad ? .title2 : .default)
                                    .fontWeight(isIpad ? .semibold : .regular)

                                
                                Spacer()
                            }
                            .padding(isIpad ? 10 : 10)
                        }
                        
                        Divider()
                    }
                }
                .background(Color("ColorSecondary"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                .zIndex(1)
            }
        }
    }
}

#Preview {
        EmotionDropdown()
    }

