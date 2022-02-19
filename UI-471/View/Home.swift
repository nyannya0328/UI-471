//
//  Home.swift
//  UI-471
//
//  Created by nyannyan0328 on 2022/02/19.
//

import SwiftUI

struct Home: View {
    @State var offset : CGFloat = 0
    
    @State var widht : CGFloat = 1
    
    @State var height : CGFloat = UIScreen.main.bounds.height
    
    @State var cardOffset : [CGFloat] = [0,0,0,0]
    var body: some View {
        VStack(spacing:0){
            
            
            TopBar()
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                
                      let leftValue : CGFloat = (2.3 / (widht / (widht -  390)))
                      
                      let value : CGFloat = 2.3 + (leftValue < -0.5 ? 0 : leftValue)
                    
                      
                      let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
                
                VStack{
                
                    
                    Text("Wallet")
                        .font(.system(size: 65, weight: .bold))
                        .frame(height:getRect().height / 4)
                    
                    WalletView(content: {
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            
                            Text("Carry\nOne Thing\nEveryThing.")
                                .font(.largeTitle.weight(.heavy))
                                .padding(.leading,15)
                            
                            
                            
                            Text("The Wallet app lives right on your iPhone. It’s where you securely keep your credit and debit cards, driver’s license or state ID, transit cards, event tickets, keys, and more — all in one place. And it all works with iPhone or Apple Watch, so you can take less with you but always bring more.")

                                .font(.title.weight(.semibold))
                                .frame(height:400,alignment: .top)
                                .padding(15)
                            
                            
                            
                            sampleCardView(color: Color("Green"))
                            sampleCardView(color: Color("Yellow"),index: 1)
                            sampleCardView(color: Color("Green"),index: 2)
                            sampleCardView(color: Color("Orange"),index: 3)
                            
                            
                            
                        }
                        .frame(maxWidth:.infinity,alignment: .leading)
                        
                        
                        
                    })
                      //  .offset(y: offset < 0 ? -offset : 0)
                      
                    
                }
            
                
                .frame(maxWidth:.infinity)
                .mask({
                    
                    
                Rectangle()
                        .padding(.horizontal,-offset > (maxHeight + (widht > 390 ? 8 : 4)) ? 15 : 0)
                    
                })
                .modifier(OffsetModifier(coordinateSpace: "SCROLL", rect: { rect in
                    
                    
                    self.offset = (rect.minY < 0 ? rect.minY : 0)
                    
                    if widht == 1{
                        
                        self.widht = rect.width
                        
                    }
                    
                    
                }))
                .padding(.bottom,getRect().width)
                
                
            }
            .coordinateSpace(name: "SCROLL")
            
            
            
        }
        .background(Color("BG"))
    }
    
    @ViewBuilder
    func sampleCardView(color : Color,index : Int = 0) -> some View{
        
        
        GeometryReader{proxy in
            
            
            Text("ravel\nYoure Even more\nMobile Device")
                .font(.system(size: 30, weight: .bold))
                .padding(.vertical,20)
                .padding(.horizontal,20)
                .frame(maxWidth:.infinity,alignment: .leading)
                .modifier(OffsetModifier(coordinateSpace: "SCROLL", rect: { rect in
                    
                    cardOffset[index] = rect.minY
                    
                }))
                
            
        }
        .frame(height: 250, alignment: .top)
        .background(color,in: RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal,25)
        
        
    }
    @ViewBuilder
    func TopBar()->some View{
        
        
        HStack{
            
            Button {
                
            } label: {
                
                Image(systemName: "line.3.horizontal")
                
            }
            
            Spacer()
            
            
            Button {
                
            } label: {
                
                Image(systemName: "line.3.horizontal")
                
                
            }
            
            
            
            

        }
        .overlay(Image(systemName: "applelogo"))
        .font(.system(size: 30, weight: .bold))
        .foregroundColor(.white)
        .padding()
        .background(Color("TopBar"))
        
        
        
    }
    
    @ViewBuilder
    func WalletView<Content : View>(@ViewBuilder content : @escaping()->Content)->some View{
        
        
        let leftValue : CGFloat = (2.3 / (widht / (widht -  390)))
        
        let value : CGFloat = 2.3 + (leftValue < -0.5 ? 0 : leftValue)
        
        let scale : CGFloat = -(offset / 200) < value ? (offset / 200) : -(value + (widht > 390 ? 0.1 : 0.001))
        
        
        let scaleOffset : CGFloat = (offset + (200 * value))
        
        let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
        
        let exHaustHeight : CGFloat = -(200 * value)
        
        VStack{
            
            GeometryReader{proxy in
                
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 35)
                        .offset(y: -scale > value ? -scaleOffset / 6 : 0)
                        .opacity(-offset > maxHeight ? 0 : 1)
                    
                    
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("BG"))
                        .padding(.horizontal,25)
                        .padding(.vertical,35)
                        .offset(y: -scale > value ? -scaleOffset / 10 : 0)
                    
                    ZStack{
                        
                      
                        
                        
                        WalletCard(color: Color("Blue"), hPadding: 35, vPadding: 45)
                        WalletCard(color: Color("Green"), hPadding: 35, vPadding: 55,index: 1)
                        WalletCard(color: Color("Yellow"), hPadding: 35, vPadding: 65,index: 2)
                        WalletCard(color: Color("Orange"), hPadding: 35, vPadding: 75,index: 3)
                        
                        
                    Rectangle()
                            .fill(Color("BG"))
                            .padding(.horizontal,35)
                            .padding(.vertical,65)
                            .offset(y: 25)
                        
                        
                        Circle()
                            .trim(from: 0, to: 0.5)
                            .fill(Color("Orange"))
                            .frame(width: 40, height: 40)
                            .offset(y: -5)
                        
                    }
                }
                .onAppear {
                    self.height -= proxy.frame(in: .global).minY
                }
            }
            .frame(width: 200, height: 190)
          
            .scaleEffect(1 - scale)
            .offset(y: -offset)
            .offset(y: -offset < maxHeight ? (-scale > value ? -scaleOffset : 0) : maxHeight + exHaustHeight)
            .zIndex(100)
            
            content()
                .padding(.top,maxHeight)
        }
        
      
        
        
    }
    
    @ViewBuilder
    func WalletCard(color : Color,hPadding : CGFloat,vPadding : CGFloat,index : Int = 0)->some View{
        
        
        
        
        GeometryReader{proxy in
            
            let minY = proxy.frame(in: .named("SCROLL")).minY - 20
            
            let paddleWidth = proxy.frame(in: .named("SCROLL")).width
            
            let scale = paddleWidth / widht
            
            
            
            
            let leftValue : CGFloat = (2.3 / (widht / (widht -  390)))
            
            let value : CGFloat = 2.3 + (leftValue < -0.5 ? 0 : leftValue)
            
            let maxHeight : CGFloat = (height + (180 - 65) * (value + 1))
            
            
            RoundedRectangle(cornerRadius: 8)
                .fill(color)
                .opacity(cardOffset[index] < minY ? 0 : 1)
                .scaleEffect(-offset > maxHeight ? scale : 1)
        }
        .padding(.horizontal,hPadding)
        .padding(.vertical,vPadding)
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
