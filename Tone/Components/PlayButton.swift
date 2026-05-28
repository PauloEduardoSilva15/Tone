//
//  PlayButton.swift
//  Tone
//
//  Created by Gabriel Groppo on 22/05/26.
//

import SwiftUI

struct PlayButton: View{
    @Environment(CarouselViewModel.self) var viewModel
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var action: () -> Void;
    
    var body: some View{
        
        Button(action: {
            action()
        }) {
            Image(systemName: "play.fill")
                .foregroundColor(viewModel.sentimentoSelecionado == .nenhum ? .gray : .white)
                .font(.title3)
                .frame(width: isIpad ? 60 : 42, height: isIpad ? 60 : 42)
                .background(viewModel .sentimentoSelecionado == .nenhum ? .colorPrimary.opacity(0.3) :
                        .colorPrimary)
                .clipShape(Circle())
        }
        .zIndex(1)
        
    }
}

#Preview {
    PlayButton(){
        
    }
    .environment(CarouselViewModel())
}
