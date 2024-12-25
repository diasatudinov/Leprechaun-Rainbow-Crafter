import SwiftUI

struct ShopView: View {
    @StateObject var user = User.shared
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ShopViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.backBtn)
                                .resizable()
                                .scaledToFit()
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:55)
                        
                    }
                    Spacer()
                    
                    HStack(spacing: 5){
                        Spacer()
                        
                        ZStack {
                            Image(.coinsBg)
                                .resizable()
                                .scaledToFit()
                            
                            Text("\(user.coins)")
                                .font(.system(size: DeviceInfo.shared.deviceType == .pad ? 40:20, weight: .black))
                                .foregroundStyle(.white)
                                .textCase(.uppercase)
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    
                
            }.padding([.top,.horizontal], 20)
                HStack {
                    
                    ForEach(viewModel.bonuses, id: \.self) { bonus in
                        itemView(image: bonus.icon, header: bonus.name, isPurchased: bonus.purchased, bonus: bonus)
                    }
                    
                    
                }
                Spacer()
            }
            
        }.background(
            Image(.bg)
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
            
        )
    }
    
    @ViewBuilder func itemView(image: String, header: String, isPurchased: Bool, bonus: Bonus) -> some View {
        
        
        ZStack {
            
            Image(.shopBg)
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .center, spacing: 15) {
                
                Image(image)
                    .resizable()
                    .foregroundColor(.black)
                    .scaledToFit()
                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 160 : 80)
                    
                
                Text(header)
                    .font(.system(size: DeviceInfo.shared.deviceType == .pad ? 40:20, weight: .bold))
                    .foregroundColor(.white)
                    .textCase(.uppercase)
                Button {
                    if !isPurchased {
                        if user.coins > 50 {
                            viewModel.purchaseBonus(bonus: bonus)
                            user.minusUserCoins(for: 50)
                        }
                    }
                } label: {
                    Image(isPurchased ? .shopBtnGreen : user.coins < 50 ? .shopBtnRed : .shopBtn)
                        .resizable()
                        .foregroundColor(.black)
                        .scaledToFit()
                        .frame(height: DeviceInfo.shared.deviceType == .pad ? 80 : 50)
                }
                
            }
        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 450:270)
    }
}

#Preview {
    ShopView(viewModel: ShopViewModel())
}
