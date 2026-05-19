//
//  MainPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct MainPage: View {
    @State private var showAcordes: Bool = false
    var body: some View {
        NavigationStack{
            ZStack(){
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack{
                    Image("SmallLogo")
                        .padding(.trailing, 250)
                        .padding(.top, 10)
                    Spacer()
                    
                    Text("Escolha o tom")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(.title2)
                    
                    Spacer()
                    
                    Text("Quer expressar algo?")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(.title2)
                    Spacer()
                    
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(.title2)
                    Spacer()
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .foregroundStyle(Color.white)
                            .frame(width: 150, height: 50)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                        ChordsPage()
                    }
                    .padding(.bottom, 20)
                    
                }}}
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MainPage()
}
