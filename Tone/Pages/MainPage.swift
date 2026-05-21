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
            Image("BackGroundImage")
                .resizable()
                .frame(height: isIpad ?  1300 : 920)
            VStack{
                Image(isIpad ? "MediumLogo" : "SmallLogo")
                    .padding(.trailing, isIpad ? 580 : 280)
                    .padding(.top, isIpad ? 100 : 60)
                Spacer()
                
                Text("Escolha o tom")
                    .foregroundStyle(Color("ColorSecondary"))
                    .font(isIpad ? .title : .title2)
                    .fontWeight(isIpad ? .bold : .semibold)
                ChoiceKeyCarroussel()
                    .padding(.horizontal, isIpad ? 120 : 40)
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
                
                HStack{
                    EmotionDropdown()
                    Spacer()
                    Button(action:{
                        showAcordes = true
                    }) {
                        Image("PlayButton")
                            .resizable()
                            .frame(width: isIpad ? 60 : 40, height: isIpad ? 60 : 40)
                        
                    }
                    .padding(.trailing, isIpad ? 115 : 28)
                    .zIndex(1)}
                
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
                .padding(.bottom, isIpad ? 100 : 60)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MainPage()
}
