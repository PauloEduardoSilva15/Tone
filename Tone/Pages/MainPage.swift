//
//  MainPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct MainPage: View {
    @State private var showAcordes: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    var body: some View {
            ZStack(){
                Color("BackgroundColor")
                    .ignoresSafeArea()
                VStack{
                    Image(isIpad ? "MediumLogo" : "SmallLogo")
                        .padding(.trailing, isIpad ? 580 : 280)
                        .padding(.top, 10)
                    Spacer()
                    
                    Text("Escolha o tom")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    ChoiceKeyCarroussel()
                        .padding(.horizontal, 150)
                    Spacer()
                    
                    Text("Escolha a escala")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    Spacer()
                    ScaleChoice()
                   
                    Spacer()
                    Text("Quer expressar algo?")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    
                    EmotionDropdown()
                        .zIndex(1)
                   Spacer()
                    
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    ViewHarmonyCamp()
                    Spacer()
                    
                    
                    
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .font(isIpad ? .title : .body)
                            .foregroundStyle(Color.white)
                            .frame(width: isIpad ? 250: 150, height: isIpad ? 60 : 50)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                        ChordsPage()
                    }
                    .padding(.bottom, 10)
                    
                }}
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MainPage()
}
