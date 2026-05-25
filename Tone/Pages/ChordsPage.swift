//
//  ChordsPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
import SwiftUI

struct ChordsPage: View {
    
    @Environment(\.dismiss) var dismiss
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var body: some View {
        
        ZStack {
            
            Image("BackGroundImage")
                .resizable()
                .frame(height: isIpad ?  1300 : 960)
            
            VStack {
                
                Spacer()
                
                Text("Selecione um modo de visualização")
                    .foregroundStyle(Color("ColorSecondary"))
                    .font(isIpad ? .title : .title2)
                    .fontWeight(isIpad ? .bold : .semibold)
                
                Spacer()
                
                Text("Clique no acorde para ouví-lo")
                    .foregroundStyle(Color("ColorSecondary"))
                    .font(isIpad ? .title : .title2)
                    .fontWeight(isIpad ? .bold : .semibold)
                
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
                    .foregroundStyle(Color(.white))
                    .font(isIpad ? .title : .title2)
                    .fontWeight(isIpad ? .bold : .semibold)
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
