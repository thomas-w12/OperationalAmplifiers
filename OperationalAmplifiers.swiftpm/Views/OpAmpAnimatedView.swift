//


import SwiftUI

struct OpAmpAnimatedView: View {
    
    @State private var pathProgress = 0.0
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .shadow(radius: 20)
                
                VStack {
                    Text("Electronic symbol of Op-Amps")
                        .font(AppHelperClass.boldedTextFont)
                        .padding(.top ,geo.size.height*0.03)
                        .padding(.bottom ,geo.size.height*0.02)
                    
                    OpAmpIN()
                        .trim(from: 0.0, to: pathProgress)
                        .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .aspectRatio(1.3,contentMode: .fit)
                        .padding(geo.size.width*0.05)
                        .animation(.easeInOut(duration: 5).delay(0.6), value: pathProgress)
                    
                }
                
            }
            .padding(geo.size.width*0.05)
            
        }
        .onAppear {
            pathProgress = 1.0
        }
        
    }
}



struct BackgroundRectangleView<Content> : View where Content: View{
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                RoundedRectangle(cornerRadius: 30)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .shadow(radius: 20)
                
                
                content()
                
            }
            .padding(geo.size.width*0.025)
        }
    }
    
    @ViewBuilder
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}



struct OpAmpAnimatedView_Previews: PreviewProvider {
    static var previews: some View {
        
        OpAmpAnimatedView()
    }
}

