//


import SwiftUI
import IrregularGradient

struct StartView: View {
    
    @ObservedObject var appState: AppState
    
    @State var animated = false
    
    private let colors: [Color] = [.red, .red, .blue.opacity(0.5)]
    
    var body: some View {
        GeometryReader { geo in
            
            
            ZStack {
                
                
                GeometryReader { geo in
                    VStack {
                        ForEach(0..<Int(floor(geo.size.height/100)), id: \.self) { i in
                            HStack {
                                ForEach(0..<Int(floor(geo.size.width/100)), id: \.self) { j in
                                    BackgroundElementView(views: [AnyView(OpAmpElectronicSymbolView()), AnyView(OpAmpElectronicSymbolDEView()), AnyView(SOT6View()), AnyView(TransistorIconView()), AnyView(ResistorIconView()), AnyView(LEDIconView()), AnyView(ChipIconView()), AnyView(CircuitIconView())])
                                }
                            }
                        }
                        
                    }
                    
                }
                .padding(40)
                .opacity(0.5)
                
                VStack(alignment: .center) {
                    Text("Operational Amplifiers")
                        .multilineTextAlignment(.center)
                        .font(.custom("Orbitron-Bold", size: 80))
                        .irregularGradient(colors: colors, background: Color.accentColor, speed: 2)
                        .background {
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundColor(.white)
                                .blur(radius: 10)
                                .shadow(color: .white, radius: 50)
                                .scaleEffect(x: 1.1, y: 1.3)
                        }
                    
                        .padding(geo.size.height*0.025)
                    
                    
                    Text("The fundamental building blocks of analogue electronic circuits")
                        .multilineTextAlignment(.center)
                        .font(.custom("Quicksand-SemiBold", size: 28))
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .blur(radius: 10)
                                .shadow(color: .white, radius: 30)
                                .scaleEffect(x: 1.1, y: 2)
                            
                        }
                        .padding(.top, geo.size.height*0.05)
                    
                    
                    
                }
                
                VStack {
                    Spacer()
                    Text("Tap anywhere to start")
                        .font(.custom("Quicksand-Medium", size: 20))
                        .padding(.bottom, 10)
                }
            }
            .onTapGesture {
                withAnimation {
                    appState.previousPage = appState.currentPage
                    appState.currentPage  = .first
                }
            }
        }
        
    }
    
    
    
    
}

struct BackgroundElementView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let numberOfViews: Int
    let views: [AnyView]
    @State var currentView: Int
    var body: some View {
        Group {
            views[currentView]
        }
        .onReceive(timer) { _ in
            currentView = Int.random(in: 0..<numberOfViews)
        }
    }
    
    init(views: [AnyView]) {
        self.views = views
        self.numberOfViews = views.count
        self.currentView = Int.random(in: 0..<numberOfViews)
    }
    
}



struct ElementView<Content: View>: View {
    
    let content: Content
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: geo.size.width*0.15)
                    .foregroundColor(.white)
                    .opacity(0.7)
                    .shadow(radius: geo.size.width*0.1)
                
                content
                    .padding(geo.size.width*0.05)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(geo.size.width*0.1)
        }
        
    }
}

struct OpAmpElectronicSymbolView: View {
    var body: some View {
        ElementView(content: OpAmpIN_withoutInput().stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)).aspectRatio(1.3,contentMode: .fit))
            .frame(maxWidth: 100)
    }
}

struct DIL14View: View {
    var body: some View {
        ElementView(content: Image("DIL14").resizable())
            .frame(maxWidth: 100)
    }
}

struct OpAmpElectronicSymbolDEView: View {
    var body: some View {
        ElementView(content: OpAmp().stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round)))
            .frame(maxWidth: 600)
    }
}

struct SOT6View: View {
    var body: some View {
        ElementView(content: Image("SOT6_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

struct ResistorIconView: View {
    var body: some View {
        ElementView(content: Image("Resistor_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

struct TransistorIconView: View {
    var body: some View {
        ElementView(content: Image("Transistor_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

struct CircuitIconView: View {
    var body: some View {
        ElementView(content: Image("Circuit_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

struct ChipIconView: View {
    var body: some View {
        ElementView(content: Image("Chip_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

struct LEDIconView: View {
    var body: some View {
        ElementView(content: Image("LED_Icon").resizable())
            .frame(maxWidth: 100)
    }
}

// Icons from https://icons8.de

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(appState: AppState.init())
    }
}
