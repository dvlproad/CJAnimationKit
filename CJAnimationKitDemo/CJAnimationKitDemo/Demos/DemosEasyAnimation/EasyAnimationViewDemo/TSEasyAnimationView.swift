//
//  TSEasyAnimationView.swift
//  CJAnimationKitDemo
//
//  Created by qian on 2025/1/11.
//  Copyright © 2025 dvlproad. All rights reserved.
//


import SwiftUI
import CJAnimationKit_Swift

struct TSEasyAnimationView: View {
    @State private var bounce = false   // 是否弹跳
    @State private var swing = false    // 是否摆动
    @State private var rotate = false   // 是否旋转
    @State private var breathe = false  // 是否呼吸
    @State private var pulse = false    // 是否脉冲
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 100, height: 100)
                .bounceAnimation($bounce)
                .onTapGesture {
                    bounce.toggle()
                }
            
            Rectangle()
                .fill(Color.red)
                .frame(width: 100, height: 100)
                .swingAnimation($swing)
                .onTapGesture {
                    swing.toggle()
                }
            
            Image(systemName: "arrow.2.circlepath")
                .resizable()
                .frame(width: 100, height: 100)
                .rotateAnimation($rotate)
                .onTapGesture {
                    rotate.toggle()
                }
            
            Circle()
                .fill(Color.green)
                .breatheAnimation($breathe)
                .onTapGesture {
                    breathe.toggle()
                }
            
            Circle()
                .stroke(Color.purple, lineWidth: 4)
                .pulseAnimation($pulse)
                .onTapGesture {
                    pulse.toggle()
                }
        }
        .onAppear() {
            bounce = true
            swing = true
            rotate = true
            breathe = true
            pulse = true
        }
    }
}

struct TSEasyAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TSEasyAnimationView()
    }
}
