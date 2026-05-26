//
//  File.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//

import SwiftUI

struct ScaleChoice: View {
    /////////////////////////////////////////////////////////
    // Com o @EnvironmentObject você declara uma variável que receberá um objeto observável do tipo declarado 'KeyModel'
    @EnvironmentObject var key: KeyModel
    /////////////////////////////////////////////////////////
    
    let scales = ["Maior", "Menor"]
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        
        HStack{
            
            ForEach(scales, id: \.self) { scale in
                
                Button(action: {
                    key.escolherEscala(add: scale)
                }) {
                    
                    Text(scale)
                        .font(isIpad ? .title2 : .body)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            key.escalaSelecionada == scale
                            ? .white
                            : Color(.black)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, isIpad ? 8 : 6)
                        .background(
                            key.escalaSelecionada == scale
                            ? Color("ColorPrimary")
                            : Color.clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
            }
        }
        .padding(5)
        .background(Color("ColorSecondary"))
        .clipShape(RoundedRectangle(cornerRadius: 40))
            }
}

#Preview {
    ScaleChoice()
    /////////////////////////////////////////////////////////
    // Passa o .environmentObject(Object()) para que o preview não crashe e saiba qual tipo de objeto ele está olhando
        .environmentObject(KeyModel())
    /////////////////////////////////////////////////////////
}

