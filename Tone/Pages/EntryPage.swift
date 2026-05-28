//
//  EntryPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct EntryPage: View {
    
    @State private var mostrarMain = false
    @State private var opacity = 1.0
    
    var body: some View {
        NavigationStack{
            ZStack {
                
                if mostrarMain {
                    
                    MainPage()
                        .transition(.opacity)
                }
                
                if opacity > 0 {
                    
                    ZStack {
                        
                        Image("EntryPage")
                            .resizable()
                            .ignoresSafeArea()
                        
                        Image("Logo")
                            .padding(.bottom, 30)
                    }
                    .opacity(opacity)
                    .transition(.opacity)
                }
            }
            .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    
                    withAnimation(.easeInOut(duration: 1.2)) {
                        
                        opacity = 0
                        mostrarMain = true
                    }
                }
            }
        }
    }
}
#Preview {
    EntryPage()
        .environment(CarouselViewModel())
}
