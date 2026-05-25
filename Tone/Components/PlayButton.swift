//
//  PlayButton.swift
//  Tone
//
//  Created by Gabriel Groppo on 22/05/26.
//

import SwiftUI

struct PlayButton: View{
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var corEmocao: Color
    var body: some View{
        Button(action: {
            
        }) {
            
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.title3)
                .frame(width: isIpad ? 60 : 42, height: isIpad ? 60 : 42)
                .background(corEmocao)
                .clipShape(Circle())
        }
        
        
        .zIndex(1)
    }
}

#Preview {
    PlayButton(corEmocao: Color("ColorPrimary"))
}
