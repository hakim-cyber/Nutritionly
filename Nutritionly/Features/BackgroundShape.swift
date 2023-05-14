//
//  BackgroundShape.swift
//  Nutritionly
//
//  Created by aplle on 5/13/23.
//

import Foundation
import SwiftUI
struct BackgroundShape: Shape {

    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y:0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX , y: rect.maxY ), control: CGPoint(x: rect.midX + 100, y: rect.maxY - 20))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.midX - 100 , y: rect.maxY + 30))
        return path
    }
}
struct BackgroundShape2: Shape {

    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y:0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.midX , y: rect.maxY ), control: CGPoint(x: rect.midX + 100, y: rect.maxY + 20))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: CGPoint(x: rect.midX - 100 , y: rect.maxY - 30))
        return path
    }
}

struct BackGround: View {
    var namespace:Namespace.ID
   
    var body: some View{
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
                .safeAreaInset(edge: .top){
                    ZStack{
                        BackgroundShape()
                            .fill(.ultraThinMaterial)
                            .frame(maxWidth:  .infinity , maxHeight: UIScreen.main.bounds.height / 2.2, alignment: .top)
                            .edgesIgnoringSafeArea(.top)
                            .matchedGeometryEffect(id: "background1", in: namespace)
                       
                            
                        BackgroundShape()
                            .fill(Color.white)
                            .frame(maxWidth:  .infinity , maxHeight: UIScreen.main.bounds.height / 2, alignment: .top)
                            .edgesIgnoringSafeArea(.top)
                            .matchedGeometryEffect(id: "background2", in: namespace)
                           
                        
                        
                        
                    }
                }
        }
    }
}

struct BackGround2: View {
    var namespace:Namespace.ID
    var animated:Bool
    var body: some View{
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
                .safeAreaInset(edge: .top){
                    ZStack{
                        BackgroundShape()
                            .fill(.ultraThinMaterial)
                            .frame(maxWidth:  .infinity , maxHeight:animated ? 0:UIScreen.main.bounds.height / 2.2, alignment: .top)
                            .edgesIgnoringSafeArea(.top)
                            .matchedGeometryEffect(id: "background1", in: namespace)
   
                        BackgroundShape()
                            .fill(Color.white)
                            .frame(maxWidth:  .infinity , maxHeight:animated ? 0: UIScreen.main.bounds.height / 2.2, alignment: .top)
                            .edgesIgnoringSafeArea(.top)
                            .matchedGeometryEffect(id: "background2", in: namespace)
                           
                        
                        
                        
                        
                    }
                }
        }
    }
}
