//


import SwiftUI
import UniformTypeIdentifiers
import ConfettiSwiftUI
import LaTeXSwiftUI


struct ResistorViewUS: View {
    
    @Binding var resistor: Resistor
    @Binding var showValue: Bool
    @Binding var showName: Bool
    
    private let resistorNameLaTeXString: String
    private let textRotationAngle: Angle
    
    var body: some View {
        
        GeometryReader { geo in
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white.opacity(0.0001))
                .overlay {
                    ZStack {
                        LaTeX(showValue ? resistor.displayValue : "?")
                        //.rotationEffect(textRotationAngle)
                            .font(.custom("Quicksand-Regular", size: 20))
                            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).maxY*0.1)
                        
                        LaTeX(resistorNameLaTeXString)
                            .rotationEffect(textRotationAngle)
                            .font(.custom("Quicksand-Regular", size: 20))
                            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).maxY*0.9)
                            .opacity(showName ? 1 : 0)
                        
                        ResistorShapeUS()
                            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                            .frame(alignment: .center)
                            .scaleEffect(4/3)
                            .aspectRatio(8/3, contentMode: .fit)
                    }
                }
        }
        .aspectRatio(1.5, contentMode: .fit)
    }
    
    init(resistor: Binding<Resistor>, showValue: Binding<Bool>, resistorNameLateXString: String = "", showName: Binding<Bool> = .constant(false), textRotationAngle: Angle = Angle(degrees: 0)) {
        self._resistor = resistor
        self._showValue = showValue
        self.resistorNameLaTeXString = resistorNameLateXString
        self._showName = showName
        self.textRotationAngle = textRotationAngle
    }
}


struct ResistorDragView: View {
    
    var resistor: Resistor
    
    var body: some View {
        ResistorViewUS(resistor: .constant(resistor), showValue: .constant(true))
            .draggable(resistor)
    }
}

struct ResistorDropView: View {
    
    
    private var resistorNameLaTeXString: String
    private var textRotationAngle: Angle
    private var evaluateDrop = false
    
    @Binding var resistor: Resistor
    @Binding var animateWrongDrop: Bool
    @Binding var userCorrect: Bool
    @Binding var showValue: Bool
    @Binding var acceptDrop: Bool
    @Binding var userScore: Int
    //@State private var confetti: Int = 0
    @State private var numberOfFalseDrops: Int = 0
    
    
    var body: some View {
        ResistorViewUS(resistor: $resistor, showValue: $showValue, resistorNameLateXString: resistorNameLaTeXString, showName: .constant(true), textRotationAngle: textRotationAngle)
            .foregroundColor(showValue ? .black : .gray)
            .if(acceptDrop) { view in
                view.dropDestination(for: Resistor.self) { items, location in
                    if let item = items.first {
                        if evaluateDrop {
                            if item == resistor {
                                self.showValue = true
                                //confetti += 1
                                userCorrect = true
                                userScore += (10-numberOfFalseDrops*2)
                            } else {
                                animateViewOnFalseDrop()
                                numberOfFalseDrops += 1
                            }
                        } else {
                            self.resistor = item
                        }
                        
                    }
                    return true
                } isTargeted: { boolValue in
                    //
                    
                }
            }
        
        
        
    }
    
    func animateViewOnFalseDrop() {
        withAnimation(.interactiveSpring (response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
            animateWrongDrop = true
            DispatchQueue.main.asyncAfter (deadline: .now() + 0.1) {
                withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.2, blendDuration: 0.2)){
                    animateWrongDrop = false
                }
            }
        }
    }
    
    init(resistor: Binding<Resistor>, showValue: Binding<Bool> = .constant(false), evaluateDrop: Bool = false, resistorNameLateXString: String = "", textRotationAngle: Angle = Angle(degrees: 0), animateWrongDrop: Binding<Bool>, userCorrect: Binding<Bool> = .constant(true), acceptDrop: Binding<Bool> = .constant(true), userScore: Binding<Int> = .constant(0)) {
        self._resistor = resistor
        self._showValue = showValue
        self.evaluateDrop = evaluateDrop
        self.textRotationAngle = textRotationAngle
        self.resistorNameLaTeXString = resistorNameLateXString
        self._animateWrongDrop = animateWrongDrop
        self._userCorrect = userCorrect
        self._acceptDrop = acceptDrop
        self._userScore = userScore
    }
    
}





struct Resistor: Codable, Identifiable, Equatable, Transferable {
    
    
    var value: Int //
    
    var id: Int {
        value
    }
    
    var displayValue: String {
        let valueInKOhm: String = String(format: "%.2f", Double(value)/1000)
        return "$\(valueInKOhm)\\;k\\Omega$"
        
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: Resistor.self, contentType: .resistor)
    }
    
    static func == (lhs: Resistor, rhs: Resistor) -> Bool {
        lhs.id == rhs.id
    }
    
    init(value: Int) {
        self.value = value
    }
    
}

extension UTType {
    static var resistor = UTType(exportedAs: "com.thomas-w12.operational-amplifier.resistor")
}

// Preview content

struct ResistorView_Previews: PreviewProvider {
    static var previews: some View {
        ResistorPreview()
        
    }
}

struct ResistorPreview: View {
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<3) { i in
                    ResistorDragView(resistor: Resistor(value: (i+1)*1000))
                        .frame(maxHeight: 70)
                }
            }
            
            
            ResistorDropView(resistor: .constant(Resistor(value: 100)), showValue: .constant(true), resistorNameLateXString: "$R_{in}$", textRotationAngle: Angle(degrees: 90), animateWrongDrop: .constant(true), acceptDrop: .constant(false))
        }
    }
}

