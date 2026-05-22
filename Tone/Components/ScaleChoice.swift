//
//  File.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//

import SwiftUI

struct ScaleChoice: View {
    @State private var viewModel = CarouselViewModel()
    //@State private var selectedScale = "Maior"
    
    let scales = ["Maior", "Menor"]
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    var body: some View {
        
        HStack{
            
            ForEach(scales, id: \.self) { scale in
                
                Button(action: {
                    viewModel.escolherEscala(add: scale)
                }) {
                    
                    Text(scale)
                        .font(isIpad ? .title2 : .body)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            viewModel.escalaSelecionada == scale
                            ? .white
                            : Color(.black)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, isIpad ? 12 : 6)
                        .background(
                            viewModel.escalaSelecionada == scale
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
    }

