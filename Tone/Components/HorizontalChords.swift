//
//  HorizontalChords.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//

import SwiftUI

struct HorizontalChords: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var botaoSelecionado: Int = 1
    @Environment(CarouselViewModel.self) var viewModel

    var body: some View {
        
        ZStack {
            
            Image("BackGroundImage")
                .resizable()
                .ignoresSafeArea()
            AnimatedStarsOverlay()
            
            HStack{
                VStack {
                    Text("Acordes")
                        .font(sizeClass == .regular ? .largeTitle : .title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("ColorSecondary"))
                    Text("Selecione um modo de visualização")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(sizeClass == .regular ? .title3 : .body)
                        .fontWeight(sizeClass == .regular ? .bold : .semibold)
                        .padding(.vertical, 30)
                    
                    //Spacer()
                    
                    
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
                    }}
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 50)
                    
                
                Rectangle()
                    .fill(Color.colorSecondary)
                    .frame(width: 1, height: .infinity)
                    .ignoresSafeArea()
                Spacer()
                VStack(alignment: .center){
                    Text("Selecione o acorde para ouví-lo")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(sizeClass == .regular ? .title : .body)
                        .fontWeight(sizeClass == .regular ? .semibold : .semibold)
                        .padding(.bottom, 30)
                    switch botaoSelecionado {
                        case 1:
                            ViewModeChord()
                        
                        case 2:
                            ViewModePiano()
                        
                        case 3:
                            ViewModeGuitar()
                    default:
                        ViewModeChord()
                    }
                    
                    
                    
                }
                .padding(.leading, 100)
                .padding(.trailing, 160)
                .padding(.bottom, 40)
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
            }}
            
        }
}

#Preview {
    NavigationStack {
        ChordsPage()
            .environment(CarouselViewModel())
    }
}
