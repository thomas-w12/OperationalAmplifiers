//


import Foundation
import SwiftUI

struct OpAmp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let w = rect.width
        let h = rect.height
        
        let opAmpRectangleWidth: Double = rect.width*0.5
        let opAmpRectangleHeight: Double = rect.height
        
        // Rectangle
        path.addRect(CGRect(origin: CGPoint(x: rect.width*0.25, y: rect.minY), size: CGSize(width: opAmpRectangleWidth, height: opAmpRectangleHeight)))
        
        // Inputs
        path.move(to: CGPoint(x: w*0.25, y: rect.height*0.4))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height*0.4))
        
        path.move(to: CGPoint(x: rect.minX, y: rect.height*0.8))
        path.addLine(to: CGPoint(x: rect.width*0.25, y: rect.height*0.8))
        
        path.move(to: CGPoint(x: rect.width*0.25+opAmpRectangleWidth, y: rect.height*0.6))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height*0.6))
        path.closeSubpath()
        
        // Plus symbol
        path.move(to: CGPoint(x: rect.width*0.35, y: rect.height*0.8))
        path.addLine(to: CGPoint(x: rect.width*0.45, y: rect.height*0.8))
        path.move(to: CGPoint(x: rect.width*0.4, y: rect.height*0.75))
        path.addLine(to: CGPoint(x: rect.width*0.4, y: rect.height*0.85))
        path.closeSubpath()
        
        // Minus symbol
        path.move(to: CGPoint(x: rect.width*0.35, y: rect.height*0.4))
        path.addLine(to: CGPoint(x: rect.width*0.45, y: rect.height*0.4))
        path.closeSubpath()
        
        // amplification symbol
        path.move(to: CGPoint(x: rect.width*0.35, y: rect.height*0.1))
        path.addLine(to: CGPoint(x: rect.width*0.35, y: rect.height*0.2))
        path.addLine(to: CGPoint(x: rect.width*0.45, y: rect.height*0.15))
        path.closeSubpath()
        
        // infinity symbol
        let infinitySymbolOrigin = CGPoint(x: rect.width*0.6, y: rect.height*0.15)
        path.move(to: infinitySymbolOrigin)
        path.addCurve(to: infinitySymbolOrigin, control1: CGPoint(x: w*0.7, y: h*0.05), control2: CGPoint(x: w*0.7, y: h*0.25))
        path.addCurve(to: infinitySymbolOrigin, control1: CGPoint(x: w*0.5, y: h*0.05), control2: CGPoint(x: w*0.5, y: h*0.25))
        
        
        // output plus symbol
        
        path.move(to: CGPoint(x: w*0.55, y: h*0.6))
        path.addLine(to: CGPoint(x: w*0.65, y: h*0.6))
        path.move(to: CGPoint(x: w*0.6, y: h*0.55))
        path.addLine(to: CGPoint(x: w*0.6, y: h*0.65))
        path.closeSubpath()

        return path //.strokedPath(StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
    }
}


struct ResistorShapeDE: Shape {
    
    // Aspect Ratio 6/1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.midY))
        path.addRect(CGRect(origin: CGPoint(x: rect.width*0.2, y: rect.minY), size: CGSize(width: rect.width*0.6, height: rect.height)))
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        
        return path
    }
}

struct ResistorShapeUS: Shape {
    
    // Aspect Ratio 8/3
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.125*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.3125*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.34375*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.40625*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.46875*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.53125*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.59375*width, y: 0.33333*height))
        path.addLine(to: CGPoint(x: 0.65625*width, y: 0.66667*height))
        path.addLine(to: CGPoint(x: 0.6875*width, y: 0.5*height))
        path.addLine(to: CGPoint(x: 0.875*width, y: 0.5*height))
        return path
    }
}


struct OpAmpIN: Shape {
    
    // aspect ratio 1.3/1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
       // path.move(to: CGPoint(x: rect.width*0.05, y: rect.height*0.375))
        path.addArc(center: CGPoint(x: rect.width*0.01, y: rect.height*0.3), radius: rect.width*0.01, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.addArc(center: CGPoint(x: rect.width*0.01, y: rect.height*0.7), radius: rect.width*0.01, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: rect.width*0.02, y: rect.height*0.3))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height*0.3))
        path.move(to: CGPoint(x: rect.width*0.02, y: rect.height*0.7))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height*0.7))
        path.move(to: CGPoint(x: rect.width*0.2, y: 0))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.move(to: CGPoint(x: rect.width*0.2, y: 0))
        path.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.move(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width*0.98, y: rect.midY))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: rect.width*0.99, y: rect.midY), radius: rect.width*0.01, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()
        
       
        // non-inverting input
        path.move(to: CGPoint(x: rect.width*0.25, y: rect.height*0.3))
        path.addLine(to: CGPoint(x: rect.width*0.35, y: rect.height*0.3))
        let length = rect.width*0.1
        path.move(to: CGPoint(x: rect.width*0.3, y: rect.height*0.3-length/2))
        path.addLine(to: CGPoint(x: rect.width*0.3, y: rect.height*0.3+length/2))
        path.closeSubpath()
        
        // inverting input
        path.move(to: CGPoint(x: rect.width*0.25, y: rect.height*0.7))
        path.addLine(to: CGPoint(x: rect.width*0.35, y: rect.height*0.7))
        path.closeSubpath()
        
        return path //.strokedPath(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
    }
    
}

struct OpAmpIN_withoutInput: Shape {
    
    // aspect ratio 1.3/1
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
       // path.move(to: CGPoint(x: rect.width*0.05, y: rect.height*0.375))
        
        path.move(to: CGPoint(x: rect.width*0.02, y: rect.height*0.3))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height*0.3))
        path.move(to: CGPoint(x: rect.width*0.02, y: rect.height*0.7))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height*0.7))
        path.move(to: CGPoint(x: rect.width*0.2, y: 0))
        path.addLine(to: CGPoint(x: rect.width*0.2, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.move(to: CGPoint(x: rect.width*0.2, y: 0))
        path.addLine(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.move(to: CGPoint(x: rect.width*0.8, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.width*0.98, y: rect.midY))
        path.closeSubpath()
      
        
       
        // non-inverting input
        path.move(to: CGPoint(x: rect.width*0.25, y: rect.height*0.3))
        path.addLine(to: CGPoint(x: rect.width*0.35, y: rect.height*0.3))
        let length = rect.width*0.1
        path.move(to: CGPoint(x: rect.width*0.3, y: rect.height*0.3-length/2))
        path.addLine(to: CGPoint(x: rect.width*0.3, y: rect.height*0.3+length/2))
        path.closeSubpath()
        
        // inverting input
        path.move(to: CGPoint(x: rect.width*0.25, y: rect.height*0.7))
        path.addLine(to: CGPoint(x: rect.width*0.35, y: rect.height*0.7))
        path.closeSubpath()
        
        return path //.strokedPath(StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
    }
    
}

struct InvertingAmplifierShape: Shape {
    
    // aspect ratio 1.5/1
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let circleRadius = width*0.008
        
        path.move(to: CGPoint(x: 0.70849*width, y: 0.58891*height))
        path.addLine(to: CGPoint(x: 0.57532*width, y: 0.711*height))
        path.addLine(to: CGPoint(x: 0.4383*width, y: 0.83688*height))
        path.addLine(to: CGPoint(x: 0.4382*width, y: 0.58485*height))
        path.addLine(to: CGPoint(x: 0.4383*width, y: 0.33282*height))
        path.addLine(to: CGPoint(x: 0.57157*width, y: 0.46276*height))
        path.addLine(to: CGPoint(x: 0.70849*width, y: 0.58891*height))
        path.closeSubpath()
        
        // Input resistor
//        path.addRect(CGRect(x: 0.14596*width, y: 0.44919*height, width: 0.13932*width, height: 0.07005*height))
//        path.closeSubpath()
//
        
        path.move(to: CGPoint(x: 0.46742*width, y: 0.48415*height))
        path.addLine(to: CGPoint(x: 0.49664*width, y: 0.48415*height))
        path.move(to: CGPoint(x: 0.46742*width, y: 0.68204*height))
        path.addLine(to: CGPoint(x: 0.49664*width, y: 0.68204*height))
        path.move(to: CGPoint(x: 0.48203*width, y: 0.65876*height))
        path.addLine(to: CGPoint(x: 0.48203*width, y: 0.70532*height))
        
        
//        path.move(to: CGPoint(x: 0.02*width, y: 0.075*height))
//        path.closeSubpath()
//
        // feedback resistor
//        path.addRect(CGRect(x: 0.54777*width, y: 0.1582*height, width: 0.13932*width, height: 0.07005*height))
//        path.closeSubpath()
        
        
        
//        path.move(to: CGPoint(x: 0.02*width, y: 0.075*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.02*width, y: 0.075*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.02*width, y: 0.075*height))
//        path.closeSubpath()
        
        
        
        path.move(to: CGPoint(x: 0.28478*width, y: 0.48415*height))
        path.addLine(to: CGPoint(x: 0.43819*width, y: 0.48415*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.14598*width, y: 0.48415*height))
        path.addLine(to: CGPoint(x: 0.07293*width, y: 0.48415*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.07293*width-circleRadius, y: 0.48415*height), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.addArc(center: CGPoint(x: 0.05832*width, y: 0.91486*height-circleRadius), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: 0.05832*width, y: 0.91486*height))
        path.addLine(to: CGPoint(x: 0.05832*width, y: 0.97306*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.03641*width, y: 0.97306*height))
        path.addLine(to: CGPoint(x: 0.08024*width, y: 0.97306*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.89112*width, y: 0.91486*height-circleRadius), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: 0.89112*width, y: 0.91486*height))
        path.addLine(to: CGPoint(x: 0.89112*width, y: 0.97306*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.86921*width, y: 0.97306*height))
        path.addLine(to: CGPoint(x: 0.91304*width, y: 0.97306*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.43819*width, y: 0.68204*height))
        path.addLine(to: CGPoint(x: 0.36514*width, y: 0.68204*height))
        path.addLine(to: CGPoint(x: 0.36514*width, y: 0.97306*height))

        path.move(to: CGPoint(x: 0.34323*width, y: 0.97306*height))
        path.addLine(to: CGPoint(x: 0.38706*width, y: 0.97306*height))

        // Output
        path.move(to: CGPoint(x: 0.70849*width, y: 0.58891*height))
        path.addLine(to: CGPoint(x: 0.87651*width, y: 0.58891*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.87651*width + circleRadius, y: 0.58891*height), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.closeSubpath()

        path.move(to: CGPoint(x: 0.80346*width, y: 0.58891*height))
        path.addLine(to: CGPoint(x: 0.80346*width, y: 0.19313*height))
        path.addLine(to: CGPoint(x: 0.68657*width, y: 0.19313*height))

        path.move(to: CGPoint(x: 0.54777*width, y: 0.19313*height))
        path.addLine(to: CGPoint(x: 0.36514*width, y: 0.19313*height))
        path.addLine(to: CGPoint(x: 0.36514*width, y: 0.48415*height))
//        path.move(to: CGPoint(x: 0.07467*width, y: 0.076*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.07467*width, y: 0.076*height))
//        path.closeSubpath()
        
        // Arrow Vin
        path.move(to: CGPoint(x: 0.05832*width, y: 0.53071*height))
        path.addLine(to: CGPoint(x: 0.05832*width, y: 0.82173*height))
        path.move(to: CGPoint(x: 0.05832*width, y: 0.82173*height))
        path.addLine(to: CGPoint(x: (0.05832 - 0.02)*width, y: (0.82173 - 0.05)*height))
        path.move(to: CGPoint(x: 0.05832*width, y: 0.82173*height))
        path.addLine(to: CGPoint(x: (0.05832 + 0.02)*width, y: (0.82173 - 0.05)*height))
        path.closeSubpath()
        
        // Arrow Vout
        path.move(to: CGPoint(x: 0.89112*width, y: 0.63548*height))
        path.addLine(to: CGPoint(x: 0.89112*width, y: 0.82173*height)) // Arrow Vout
        path.move(to: CGPoint(x: 0.89112*width, y: 0.82173*height))
        path.addLine(to: CGPoint(x: (0.89112 - 0.02)*width, y: (0.82173 - 0.05)*height))
        path.move(to: CGPoint(x: 0.89112*width, y: 0.82173*height))
        path.addLine(to: CGPoint(x: (0.89112 + 0.02)*width, y: (0.82173 - 0.05)*height))
        path.closeSubpath()
        
        
//        path.move(to: CGPoint(x: 0.87333*width, y: 0.778*height))
//        path.addLine(to: CGPoint(x: 0.892*width, y: 0.85*height))
//        path.addLine(to: CGPoint(x: 0.90933*width, y: 0.778*height))
        
      //  path.addCurve(to: CGPoint(x: 0.87333*width, y: 0.778*height), control1: CGPoint(x: 0.89733*width, y: 0.796*height), control2: CGPoint(x: 0.88533*width, y: 0.796*height)) // for Arrow Vout
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.04*width, y: 0.778*height))
//        path.addLine(to: CGPoint(x: 0.05867*width, y: 0.85*height))
//        path.addLine(to: CGPoint(x: 0.076*width, y: 0.778*height))
//        path.addCurve(to: CGPoint(x: 0.04*width, y: 0.778*height), control1: CGPoint(x: 0.064*width, y: 0.796*height), control2: CGPoint(x: 0.052*width, y: 0.796*height))
//        path.closeSubpath()
        return path
    }
}

struct NonInvertingAmplifierShape: Shape {
    
    // Aspect ratio 15/11
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let circleRadius = width*0.008
        
        // Triangle
        path.move(to: CGPoint(x: 0.67886*width, y: 0.27693*height))
        path.addLine(to: CGPoint(x: 0.53038*width, y: 0.39807*height))
        path.addLine(to: CGPoint(x: 0.3776*width, y: 0.52296*height))
        path.addLine(to: CGPoint(x: 0.37749*width, y: 0.2729*height))
        path.addLine(to: CGPoint(x: 0.3776*width, y: 0.02283*height))
        path.addLine(to: CGPoint(x: 0.52619*width, y: 0.15176*height))
        path.addLine(to: CGPoint(x: 0.67886*width, y: 0.27693*height))
        path.closeSubpath()
        
        // Inverting Input Symbol
        path.move(to: CGPoint(x: 0.40389*width, y: 0.37*height))
        path.addLine(to: CGPoint(x: 0.43647*width, y: 0.37*height))
        path.closeSubpath()
        
        // Non Inverting Input Symbol
        path.move(to: CGPoint(x: 0.40389*width, y: 0.16604*height))
        path.addLine(to: CGPoint(x: 0.43647*width, y: 0.16604*height)) // Length: 0.03258*width
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.42018*width, y: 0.16604*height - 0.03258*width/2))
        path.addLine(to: CGPoint(x: 0.42018*width, y: 0.16604*height + 0.03258*width/2))
        path.closeSubpath()
        
        
//        path.move(to: CGPoint(x: 0.09358*width, y: 0.12114*height))
//        path.addLine(to: CGPoint(x: 0.09947*width, y: 0.12114*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.09652*width, y: 0.11702*height))
//        path.addLine(to: CGPoint(x: 0.09652*width, y: 0.12526*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.02*width, y: 0.06818*height))
//        path.closeSubpath()
       // path.addRect(CGRect(x: 0.30689*width, y: -1.03758*height, width: 0.11988*width, height: 0.06142*height))
//        path.move(to: CGPoint(x: 0.02*width, y: 0.06818*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.02*width, y: 0.06818*height))
//        path.closeSubpath()
        
        // Non Inverting Input
        path.move(to: CGPoint(x: 0.12679*width, y: 0.16604*height))
        path.addLine(to: CGPoint(x: 0.37749*width, y: 0.16604*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.12679*width-circleRadius, y: 0.16604*height), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        
        // Output
        path.move(to: CGPoint(x: 0.67678*width, y: 0.27822*height))
        path.addLine(to: CGPoint(x: 0.86412*width, y: 0.27822*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.86412*width+circleRadius, y: 0.27822*height), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
//        path.move(to: CGPoint(x: 0.07467*width, y: 0.06909*height))
//        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.07467*width, y: 0.06909*height))
//        path.closeSubpath()
        
        // Input voltage
        path.move(to: CGPoint(x: 0.11205*width, y: 0.20683*height))
        path.addLine(to: CGPoint(x: 0.11205*width, y: 0.7983*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.11205*width, y: 0.7983*height))
        path.addLine(to: CGPoint(x: (0.11205-0.02)*width, y: (0.7983-0.05)*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.11205*width, y: 0.7983*height))
        path.addLine(to: CGPoint(x: (0.11205+0.02)*width, y: (0.7983-0.05)*height))
        path.closeSubpath()
        
        // Output voltage
        path.move(to: CGPoint(x: 0.87887*width, y: 0.31901*height))
        path.addLine(to: CGPoint(x: 0.87887*width, y: 0.7983*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.87887*width, y: 0.7983*height))
        path.addLine(to: CGPoint(x: (0.87887-0.02)*width, y: (0.7983-0.05)*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.87887*width, y: 0.7983*height))
        path.addLine(to: CGPoint(x: (0.87887+0.02)*width, y: (0.7983-0.05)*height))
        path.closeSubpath()
        
        
        // Resistor R_f length: 0.58278-0.42098=0.1618
        // Position: x = 0.73878 y = 0.50188
        path.move(to: CGPoint(x: 0.73878*width, y: 0.58278*height))
        path.addLine(to: CGPoint(x: 0.73878*width, y: 0.72473*height))
        path.closeSubpath()
        //path.addRect(CGRect(x: 0.53147*width, y: -1.03758*height, width: 0.11988*width, height: 0.06142*height))
        path.move(to: CGPoint(x: 0.73878*width, y: 0.27822*height)) // Circle location 1
        path.addLine(to: CGPoint(x: 0.73878*width, y: 0.42098*height))
        path.closeSubpath()
        
        
        
//        path.addArc(center: CGPoint(x: 0.73878*width, y: 0.88789*height-circleRadius), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        
        // Resistor R_1 length: 0.16316
        // Popsition: x = 0.73878 y = 0.80631
        path.move(to: CGPoint(x: 0.73878*width, y: 0.88789*height))
        path.addLine(to: CGPoint(x: 0.73878*width, y: 0.97967*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.71666*width, y: 0.98186*height))
        path.addLine(to: CGPoint(x: 0.7609*width, y: 0.98186*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.85675*width, y: 0.98186*height))
        path.addLine(to: CGPoint(x: 0.90099*width, y: 0.98186*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.87887*width, y: 0.89008*height-circleRadius), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: 0.87887*width, y: 0.98186*height))
        path.addLine(to: CGPoint(x: 0.87887*width, y: 0.89008*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.73878*width, y: 0.65553*height)) // Circle Location 2
        path.addLine(to: CGPoint(x: 0.25951*width, y: 0.65553*height))
        path.addLine(to: CGPoint(x: 0.25951*width, y: 0.37*height))
        path.addLine(to: CGPoint(x: 0.37749*width, y: 0.37*height))
        
//        path.move(to: CGPoint(x: 0.02*width, y: 0.06818*height))
//        path.closeSubpath()
        path.move(to: CGPoint(x: 0.08993*width, y: 0.98186*height))
        path.addLine(to: CGPoint(x: 0.13417*width, y: 0.98186*height))
        path.closeSubpath()
        path.addArc(center: CGPoint(x: 0.11205*width, y: 0.89008*height-circleRadius), radius: circleRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 360), clockwise: true)
        path.move(to: CGPoint(x: 0.11205*width, y: 0.98186*height))
        path.addLine(to: CGPoint(x: 0.11205*width, y: 0.89008*height))
        path.closeSubpath()
//        path.move(to: CGPoint(x: 0.04*width, y: 0.70727*height))
//        path.addLine(to: CGPoint(x: 0.05867*width, y: 0.77273*height))
//        path.addLine(to: CGPoint(x: 0.076*width, y: 0.70727*height))
//        path.closeSubpath()
        // path.addCurve(to: CGPoint(x: 0.04*width, y: 0.70727*height), control1: CGPoint(x: 0.064*width, y: 0.72364*height), control2: CGPoint(x: 0.052*width, y: 0.72364*height))
        // path.closeSubpath()
//        path.move(to: CGPoint(x: 0.04*width, y: 0.70727*height))
//        path.addLine(to: CGPoint(x: 0.05867*width, y: 0.77273*height))
//        path.addLine(to: CGPoint(x: 0.076*width, y: 0.70727*height))
//        path.closeSubpath()
       // path.addCurve(to: CGPoint(x: 0.04*width, y: 0.70727*height), control1: CGPoint(x: 0.064*width, y: 0.72364*height), control2: CGPoint(x: 0.052*width, y: 0.72364*height))
        // path.closeSubpath()
        return path
    }
}



struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        NonInvertingAmplifierShape()
            .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .aspectRatio(15/11, contentMode: .fit)

   
    }
}

