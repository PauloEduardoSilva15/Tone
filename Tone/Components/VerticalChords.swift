//  VerticalChords.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//

import SwiftUI

struct VerticalChords: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var botaoSelecionado: Int = 1
    var body: some View {
        
        ZStack {
            
                Image("BackGroundImage")
                    .resizable()
                    
                    .ignoresSafeArea()
                AnimatedStarsOverlay()
            VStack{
                VStack {
                    Text("Acordes")
                        .font(sizeClass == .regular ? .largeTitle : .title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("ColorSecondary"))
                        .padding(.bottom, sizeClass == .regular ? 20 : 5)
                    Text("Selecione um modo de visualização")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(sizeClass == .regular ? .title : .body)
                        .fontWeight(sizeClass == .regular ? .bold : .semibold)
                        .padding(.vertical, 25)
                    
                    HStack(spacing: 20) {
                        ChordButton(id: 1,
                                    icone: "music.quarternote.3",
                                    texto: "Nota",
                                    selecaoAtual: $botaoSelecionado)
                        
                        ChordButton(id: 2,
                                    icone: "pianokeys",
                                    texto: "Piano",
                                    selecaoAtual: $botaoSelecionado)
                        
                        ChordButton(id: 3,
                                    icone: "guitars.fill",
                                    texto: "Violão",
                                    selecaoAtual: $botaoSelecionado)
                    }
                    
                    
                    
                    //Spacer()
                    VStack(alignment: .center){
                        Text("Selecione o acorde para ouví-lo")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(sizeClass == .regular ? .title : .body)
                            .fontWeight(sizeClass == .regular ? .semibold : .semibold)
                            .padding(.vertical, 25)
                        switch botaoSelecionado {
                        case 1:
                            ViewModeChord()
                            
                        case 2:
                            ViewModePiano()
                            
                        case 3:
                            ViewModeGuitar()
                                .environment(viewModel)
                        default:
                            ViewModeChord()
                        }
                        
                        
                        
                    }
                    .padding(.horizontal, 100)
                    .padding(.bottom, 40)
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("BackgroundColor"))
                            .padding(10)
                            .background(Color("ColorSecondary"))
                            .clipShape(Circle())
                    }
                    
                }
            }
            
        }}
}

#Preview {
    NavigationStack {
        VerticalChords()
            .environment(CarouselViewModel())
    }
}
