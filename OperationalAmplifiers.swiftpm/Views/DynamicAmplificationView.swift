//


import SwiftUI
import LaTeXSwiftUI


struct DynamicAmplificationView: View {
    
    @Binding var animate: Bool
    @Binding var amplification: Double
    
    @State private var path1Progress = 0.0
    @State private var path2Progress = 0.0
    @State private var animatePath1 = 0
    @State private var animatePath2 = 0
    
    var gain: CGFloat {
        CGFloat(amplification)
    }
    
    var body: some View {
        
        GeometryReader { geo in
            let w = geo.size.width
            
            HStack {
                VStack {
                    
                    HStack {
                        LaTeX("$V_{in}$")
                            .font(.custom("Quicksand-Regular", size: 20))
                            .opacity(0.6)
                            .padding(.leading, w*0.01)
                        Spacer()
                    }
                    
                    GeometryReader { g in
                        let width = g.size.width
                        let height = g.size.height
                        
                        ZStack {
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.02, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.96, y: height*0.5))
                                path.closeSubpath()
                                path.move(to: CGPoint(x: width*0.02, y: height*0.98))
                                path.addLine(to: CGPoint(x: width*0.02, y: height*0.02))
                                path.closeSubpath()
                            }
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .opacity(0.6)
                            
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.02, y: height*0.4))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*0.4))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*0.6))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*0.6))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*0.55))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*0.55))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*0.45))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*0.45))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*0.65))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.65))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.94, y: height*0.5))
                                
                            }
                            .trim(from: 0.0, to: path1Progress)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(.blue)
                            .animation(.easeInOut(duration: 1.5), value: animatePath1)
                            
                        }
                    }
                    
                }
                .frame(width: w*0.475)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        LaTeX("$V_{out}$")
                            .font(.custom("Quicksand-Regular", size: 20))
                            .opacity(0.6)
                            .padding(.leading, w*0.01)
                        Spacer()
                    }
                    
                    GeometryReader { g in
                        let width = g.size.width
                        let height = g.size.height
                        
                        ZStack {
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.02, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.96, y: height*0.5))
                                path.closeSubpath()
                                path.move(to: CGPoint(x: width*0.02, y: height*0.98))
                                path.addLine(to: CGPoint(x: width*0.02, y: height*0.02))
                                path.closeSubpath()
                            }
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
                            .opacity(0.6)
                            
                            Path { path in
                                
                                
                                path.move(to: CGPoint(x: width*0.02, y: height*(0.5-0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*(0.5-0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*(0.5+0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*(0.5+0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*(0.5+0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*(0.5+0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*(0.5-0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*(0.5-0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*(0.5+0.15*gain)))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*(0.5+0.15*gain)))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.94, y: height*0.5))
                                
                            }
                            .trim(from: 0.0, to: path2Progress)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(.red)
                            .animation(.easeInOut(duration: 1.5), value: animatePath2)
                            
                        }
                    }
                }
                .frame(width: w*0.475)
                
            }
        }
        
        .onAppear {
            // animate(animate)
        }
        .onChange(of: animate) { newValue in
            animate(newValue)
        }
        .onChange(of: gain) { newValue in
            if animate {
                path2Progress = 0.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    path2Progress = 1.0
                    animatePath2 += 1
                }
            }
            
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
        }
    }
    
}

struct DynamicAmplificationView2: View {
    
    @Binding var animate: Bool
    @Binding var amplification: Double
    
    @State private var path1Progress = 0.0
    @State private var path2Progress = 0.0
    @State private var animatePath1 = 0
    @State private var animatePath2 = 0
    
    var gain: CGFloat {
        CGFloat(amplification)
    }
    
    var body: some View {
        
        GeometryReader { geo in
            let w = geo.size.width
            
            HStack {
                VStack {
                    
                    HStack {
                        LaTeX("$V_{in}$")
                            .font(.custom("Quicksand-Regular", size: 20))
                            .opacity(0.6)
                            .padding(.leading, w*0.01)
                        Spacer()
                    }
                    GeometryReader { g in
                        let width = g.size.width
                        let height = g.size.height
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.blue)
                                .opacity(0.02)
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.0, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*1.0, y: height*0.5))
                                path.closeSubpath()
                                path.move(to: CGPoint(x: width*0.0, y: height*0.0))
                                path.addLine(to: CGPoint(x: width*0.0, y: height*1.0))
                                path.closeSubpath()
                            }
                            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                            .opacity(0.6)
                            
                            Path { path in
                                for i in 0...10 {
                                    path.move(to: CGPoint(x: width*Double(i)/10, y: height*0.0))
                                    path.addLine(to: CGPoint(x: width*Double(i)/10, y: height*1.0))
                                    path.closeSubpath()
                                    path.move(to: CGPoint(x: width*0, y: height*Double(i)/10))
                                    path.addLine(to: CGPoint(x: width*1, y: height*Double(i)/10))
                                    path.closeSubpath()
                                }
                            }
                            .stroke(style: StrokeStyle(lineWidth: 1,lineCap: .round, lineJoin: .round))
                            .opacity(0.3)
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.0, y: height*0.4))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*0.4))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*0.6))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*0.6))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*0.55))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*0.55))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*0.45))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*0.45))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*0.65))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.65))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.95, y: height*0.5))
                                
                            }
                            .trim(from: 0.0, to: path1Progress)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(.blue)
                            .animation(.easeInOut(duration: 1.5), value: animatePath1)
                            
                        }
                    }
                    
                }
                .frame(width: w*0.475)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        LaTeX("$V_{out}$")
                            .font(.custom("Quicksand-Regular", size: 20))
                            .opacity(0.6)
                            .padding(.leading, w*0.01)
                        Spacer()
                    }
                    
                    GeometryReader { g in
                        let width = g.size.width
                        let height = g.size.height
                        
                        ZStack {
                            
                            Rectangle()
                                .foregroundColor(.blue)
                                .opacity(0.02)
                            
                            Path { path in
                                path.move(to: CGPoint(x: width*0.0, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*1.0, y: height*0.5))
                                path.closeSubpath()
                                path.move(to: CGPoint(x: width*0.0, y: height*0.0))
                                path.addLine(to: CGPoint(x: width*0.0, y: height*1.0))
                                path.closeSubpath()
                            }
                            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                            .opacity(0.6)
                            
                            Path { path in
                                for i in 0...10 {
                                    path.move(to: CGPoint(x: width*Double(i)/10, y: height*0.0))
                                    path.addLine(to: CGPoint(x: width*Double(i)/10, y: height*1.0))
                                    path.closeSubpath()
                                    path.move(to: CGPoint(x: width*0, y: height*Double(i)/10))
                                    path.addLine(to: CGPoint(x: width*1, y: height*Double(i)/10))
                                    path.closeSubpath()
                                }
                            }
                            .stroke(style: StrokeStyle(lineWidth: 1,lineCap: .round, lineJoin: .round))
                            .opacity(0.3)
                            
                            Path { path in
                                
                                path.move(to: CGPoint(x: width*0.0, y: height*(0.5-0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*(0.5-0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.15, y: height*(0.5+0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*(0.5+0.1*gain)))
                                path.addLine(to: CGPoint(x: width*0.3, y: height*(0.5+0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*(0.5+0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.5, y: height*(0.5-0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*(0.5-0.05*gain)))
                                path.addLine(to: CGPoint(x: width*0.8, y: height*(0.5+0.15*gain)))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*(0.5+0.15*gain)))
                                path.addLine(to: CGPoint(x: width*0.9, y: height*0.5))
                                path.addLine(to: CGPoint(x: width*0.95, y: height*0.5))
                                
                            }
                            .trim(from: 0.0, to: path2Progress)
                            .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .round))
                            .foregroundColor(.red)
                            .animation(.easeInOut(duration: 1.5), value: animatePath2)
                            
                        }
                    }
                }
                .frame(width: w*0.475)
                
            }
        }
        
        .onAppear {
            //animate(animate)
        }
        .onChange(of: animate) { newValue in
            animate(newValue)
        }
        .onChange(of: gain) { newValue in
            if animate {
                path2Progress = 0.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    path2Progress = 1.0
                    animatePath2 += 1
                }
            }
            
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
        }
    }
    
}





struct InvertingAmplifierAmplificationView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicAmplificationView3Preview()
    }
}
