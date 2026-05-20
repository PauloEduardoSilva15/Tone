//
//  File.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//

import SwiftUI

struct ScaleChoice: View {
    
    @State private var selectedScale = "Maior"
    
    let scales = ["Maior", "Menor"]
    
    var body: some View {
        
        HStack{
            
            ForEach(scales, id: \.self) { scale in
                
                Button(action: {
                    selectedScale = scale
                }) {
                    
                    Text(scale)
                        .fontWeight(.semibold)
                        .foregroundColor(
                            selectedScale == scale
                            ? .white
                            : Color(.black)
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 6)
                        .background(
                            selectedScale == scale
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
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
    }
}

#Preview {
        ScaleChoice()
    }

