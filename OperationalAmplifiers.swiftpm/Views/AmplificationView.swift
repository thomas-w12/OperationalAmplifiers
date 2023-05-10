//


import SwiftUI
import LaTeXSwiftUI

struct AmplificationView: View {

    @Binding var animate: Bool
    @Binding var amplification: Double
    
    @State private var path1Progress = 0.0
    @State private var path2Progress = 0.0
    @State private var animatePath1 = 0
    @State private var animatePath2 = 0
    @State private var pathAmplificationParameter: Double
        
    var gain: CGFloat {
        CGFloat(amplification)
    }
    
    var body: some View {
        
        GeometryReader { geo in
            let w = geo.size.width
                
                HStack {
                    VStack {
                        
                        HStack {
                            LaTeX("$Input\\:Voltage$")
                                .opacity(0.6)
                                .padding(.leading, w*0.025)
                            Spacer()
                        }
                        
                        
                        GeometryReader { g in
                            let width = g.size.width
                            let height = g.size.height
                            
                            ZStack {
                                
                                Path { path in
                                    path.move(to: CGPoint(x: width*0.0, y: height*1.0))
                                    path.addLine(to: CGPoint(x: width*1.0, y: height*1.0))
                                    path.closeSubpath()
                                    path.move(to: CGPoint(x: width*0.0, y: height*1.0))
                                    path.addLine(to: CGPoint(x: width*0.0, y: height*0.0))
                                    path.closeSubpath()
                                }
                                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                .opacity(0.6)
                                
                                
                                Path { path in
                                    path.move(to: CGPoint(x: width*0.05, y: height*0.9))
                                    path.addQuadCurve(to: CGPoint(x: width*0.95, y: height*0.9), control: CGPoint(x: width*0.5, y: height*0.0))
                
                                }
                                .trim(from: 0.0, to: path1Progress)
                                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .foregroundColor(.blue)
                                .animation(.easeInOut(duration: 1.5), value: animatePath1)
                                
                            }
                        }
                       
                    }
                    .frame(width: w*0.4)
                    
                    
                    VStack {
                        Text("Amplification")
                            .font(.custom("Quicksand-SemiBold", size: 16))
                            .opacity(0.6)
                        
                        Text("➞")
                            .font(.system(size: 60))
                    }
                    .frame(width: w*0.2)
                    
                    VStack {
                        
                        HStack {
                            LaTeX("$Output\\:Voltage$")
                                .opacity(0.6)
                                .padding(.leading, w*0.025)
                            Spacer()
                        }
                        
                        GeometryReader { g in
                            let width = g.size.width
                            let height = g.size.height
                            
                            ZStack {
                                
                                Path { path in
                                    path.move(to: CGPoint(x: width*0.0, y: height*1.0))
                                    path.addLine(to: CGPoint(x: width*1.0, y: height*1.0))
                                    path.closeSubpath()
                                    path.move(to: CGPoint(x: width*0.0, y: height*1.0))
                                    path.addLine(to: CGPoint(x: width*0.0, y: height*0.0))
                                    path.closeSubpath()
                                }
                                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                .opacity(0.6)
                                
                                Path { path in
                                    
                                    path.move(to: CGPoint(x: width*0.05, y: height*0.9))
                                    path.addQuadCurve(to: CGPoint(x: width*0.95, y: height*0.9), control: CGPoint(x: width*0.5, y: height*(1-pathAmplificationParameter)))
                                    
                                }
                                .trim(from: 0.0, to: path2Progress)
                                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .foregroundColor(.red)
                                .animation(.easeInOut(duration: 1.5), value: animatePath2)
                                
                            }
                        }
                    }
                    .frame(width: w*0.4)
                }
            
        }

        .onAppear {
            //animate(animate)
        }
        .onChange(of: animate) { newValue in
            animate(newValue)
        }
        .onChange(of: amplification) { newValue in
            self.pathAmplificationParameter = newValue + 0.1
        }
    }
    
    func animate(_ animate: Bool) {
        if animate {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                path1Progress = 1.0
                animatePath1 += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                path2Progress = 1.0
                animatePath2 += 1
            }
        } else {
            withAnimation {
                path1Progress = 0
                path2Progress = 0
            }
        }
    }
    
    init(path1Progress: Double = 0.0, path2Progress: Double = 0.0, animatePath1: Int = 0, animatePath2: Int = 0, animate: Binding<Bool>, amplification: Binding<Double>) {
        self.path1Progress = path1Progress
        self.path2Progress = path2Progress
        self.animatePath1 = animatePath1
        self.animatePath2 = animatePath2
        self._animate = animate
        self._amplification = amplification
        self.pathAmplificationParameter = amplification.wrappedValue + 0.1

    }
    
}

// Preview content

struct DynamicAmplificationView3Preview: View {
    
    @State private var sliderValue = 1.0
    @State private var animate: Bool = false
    
    var body: some View {
        VStack {
            Toggle("Animate", isOn: $animate)
            Text("Gain: \(sliderValue)")
            Slider(value: $sliderValue, in: 0...2) {
                Text("Gain: ")
            }

            AmplificationView(animate: $animate, amplification: $sliderValue)
                .aspectRatio(2.5 ,contentMode: .fit)
        }
        
    }
}


struct AmplificationView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicAmplificationView3Preview()
        //AmplificationView(animate: .constant(true))
    }
}
