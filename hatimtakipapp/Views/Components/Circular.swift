//
//  Circular.swift
//  hatimtakipapp
//
//  Created by MrKaplan on 14.09.23.
//

import SwiftUI


struct Circular : View {
    let lineWidth : CGFloat
    let backgroundColor : Color
    let foregroundColor : Color
    var percentage : Double
    
    
    var body : some View {
           GeometryReader { geometry in
               ZStack {
                   CircularShape(percent: 100.0)
                       .stroke(style: StrokeStyle(lineWidth: lineWidth))
                       .fill(backgroundColor)
                   CircularShape(percent: percentage)
                       .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                       .fill(foregroundColor)
               }
               .animation(.easeIn(duration: 1.0), value: percentage)
               .padding(lineWidth/2)
           }
       }
   }
struct CircularShape : Shape {
    var percent : Double
    var startAngle : Double
 
    typealias AnimatableData = Double
    var animatableData: Double {
     get {
         return percent
     }
     
     set {
         percent = newValue
     }
 }
 
 init(percent: Double, startAngle: Double = -90){
     self.percent = percent
     self.startAngle = startAngle
 }
 
 static func percentToAngle(percent: Double, startAngle:Double) -> Double {
     return (percent / 100 * 360 + startAngle)
 }
 
 func path(in rect: CGRect) -> Path {
     let width = rect.width
     let height = rect.height
     let radius = min(width,height) / 2
     let center = CGPoint(x: width/2, y: height/2)
     let endAngle = Self.percentToAngle(percent: percent, startAngle: startAngle)
     
     return Path { path in
         path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: endAngle), clockwise: false)
         
     }
 }
 
}
