//
//  ChordsPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
import SwiftUI

struct ChordsPage: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Selecione um modo de visualização")
                    .foregroundStyle(Color("ColorSecondary"))
                    .font(.headline)
                
                Spacer()
                
                Text("Clique no acorde para ouví-lo")
                    .foregroundStyle(Color("ColorSecondary"))
                    .font(.headline)
                
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
            ToolbarItem(placement: .principal) {
                    Text("Acordes")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ChordsPage()
    }
}
