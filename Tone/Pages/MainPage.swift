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
        
        ViewThatFits(in: .horizontal){
            //Deitado
            ZStack{
                Image("BackGroundImage")
                    .resizable()
                    .frame(height: .infinity)
                HStack(alignment: .center){
                    VStack{
                        Image(isIpad ? "MediumLogo" : "SmallLogo")
                        
                            .padding(.trailing, isIpad ? 350 : 280)
                        
                        
                        
                        Text("Escolha o tom")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                        
                        
                        ChoiceKeyCarroussel()
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        
                        
                        
                        Text("Escolha a escala")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 30)
                        
                        ScaleChoice()
                            .padding(.bottom, 40)
                        
                        
                        //Spacer()
                        Text("Quer expressar algo?")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 20)
                        
                        HStack{
                            EmotionDropdown()
                            
                                .padding(.vertical, 10)
                            Spacer()
                            PlayButton(corEmocao: Color("ColorPrimary"))
                            
                            
                            
                        }
                        .padding(.bottom, 120)
                        Spacer()
                    }
                    .frame(width: 450)
                    .padding(.horizontal, 70)
                    Spacer()
                    VStack{
                        Spacer()
                        Text("Campo Harmônico")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                        //Spacer()
                        ViewHarmonyCamp()
                            .padding(.top, 8)
                            .padding(.bottom, 10)
                        //Spacer()
                        
                        Button(action:{
                            showAcordes = true
                        }) {
                            Text("Ver Acordes")
                                .font(isIpad ? .title : .body)
                                .foregroundStyle(Color.white)
                                .frame(width: isIpad ? 230: 150, height: isIpad ? 50 : 50)
                                .background(Color("ColorPrimary"))
                                .cornerRadius(40)
                            
                        }
                        .navigationDestination(isPresented: $showAcordes){
                            ChordsPage()
                        }
                        .padding(.bottom, isIpad ? 70 : 60)
                        Spacer()
                    }
                    .frame(width: 300)
                    .padding(.horizontal, 100)
                }
                
                .frame(maxWidth: .infinity)
                .padding(.top, isIpad ? 40 : 60)
            }
            //Em pé
            ZStack(){
                Image("BackGroundImage")
                    .resizable()
                    .frame(height: isIpad ?  1300 : 920)
                VStack{
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
                            .padding(.vertical, 10)
                        //Spacer()
                        
                        Text("Escolha a escala")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, isIpad ? 30 : 10)
                        
                        ScaleChoice()
                            .padding(.bottom, isIpad ? 30 : 10)
                        
                        
                        Text("Quer expressar algo?")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, isIpad ? 20 : 10)
                        
                        HStack{
                            EmotionDropdown()
                                .padding(.vertical, 10)
                            Spacer()
                            PlayButton(corEmocao: Color("ColorPrimary"))
                        }
                        .padding(.bottom, 10)}
                    //.padding(.horizontal, 120)
                    Spacer()
                    VStack{
                        
                        Text("Campo Harmônico")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                        ViewHarmonyCamp()
                        
                            .padding(.top, 10)
                            .padding(.bottom, isIpad ? 20 : 10)
                        
                        
                        Button(action:{
                            showAcordes = true
                        }) {
                            Text("Ver Acordes")
                                .font(isIpad ? .title : .body)
                                .foregroundStyle(Color.white)
                                .frame(width: isIpad ? 230: 120, height: isIpad ? 50 : 32)
                                .background(Color("ColorPrimary"))
                                .cornerRadius(40)
                            
                        }
                        .navigationDestination(isPresented: $showAcordes){
                            ChordsPage()
                        }
                        .padding(.bottom, isIpad ? 200 : 100)
                        Spacer()
                    }
                }
                .frame(maxWidth: isIpad ? 450 : 320)
                .padding(.top, isIpad ? 100 : 60)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    MainPage()
}
