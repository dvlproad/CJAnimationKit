//
//  CJEasyAnimationExtension.swift
//  CJAnimationKitDemo
//
//  Created by qian on 2024/12/15.
//

import SwiftUI

// 动画类型
public enum AnimationType: String, Codable {
    case none
    case bounce
    case swing
    case rotate
    case woodenFish
    case breathe
    case pulse
    
    public var description: String {
        switch self {
        case .none:
            return "无动画"
        case .bounce:
            return "弹跳"
        case .swing:
            return "摆动"
        case .rotate:
            return "旋转"
        case .woodenFish:
            return "木鱼"
        case .breathe:
            return "呼吸"
        case .pulse:
            return "脉冲"
        }
    }
}

public protocol AnimationModel: Codable {
    var type: AnimationType { get }     // 动画类型
    var isAnimating: Bool { get set }   // 是否执行动画
    var duration: CGFloat { get }       // 动画时长
    var animatingScale: CGFloat { get } // 动画的缩放比例
}

public extension View {
    
    
    // 弹跳动画
    func cjAnimation(type: AnimationType, isAnimating: Binding<Bool>) -> some View {
        var view: any View
        if type == .bounce {
            view = self.bounceAnimation(isAnimating)
        } else if type == .swing {
            view = self.swingAnimation(isAnimating)
        } else if type == .rotate {
            view = self.rotateAnimation(isAnimating)
//        } else if type == .woodenFish {
//            return self.woodenFishAnimation(isAnimating)
        } else if type == .breathe {
            view = self.breatheAnimation(isAnimating)
        } else if type == .pulse {
            view = self.pulseAnimation(isAnimating)
        } else {
            view = self
        }
        
        return AnyView(view)
    }
    
}

public extension View {
    
    
    // 弹跳动画
    func bounceAnimation(_ isAnimating: Binding<Bool>) -> some View {
        self.modifier(BounceModifier(bounce: isAnimating))
    }
    
    // 摆动动画
    func swingAnimation(_ swing: Binding<Bool>) -> some View {
        self.modifier(SwingModifier(swing: swing))
    }
    
    // 旋转动画
    func rotateAnimation(_ rotate: Binding<Bool>) -> some View {
        self.modifier(RotateModifier(rotate: rotate))
    }
    
    // 木鱼动画
    func woodenFishAnimation(_ knockModel: Binding<AnimationModel>) -> some View {
        self.modifier(WoodenFishModifier(knockModel: knockModel))
    }
    
    // 呼吸动画
    func breatheAnimation(_ breathe: Binding<Bool>) -> some View {
        self.modifier(BreatheModifier(breathe: breathe))
    }
    
    // 脉冲动画
    func pulseAnimation(_ pulse: Binding<Bool>) -> some View {
        self.modifier(PulseModifier(pulse: pulse))
    }
}

// 弹跳动画
struct BounceModifier: ViewModifier {
    @Binding var bounce: Bool
    
    func body(content: Content) -> some View {
        content
            .offset(y: bounce ? -20 : 0)
            .animation(bounce ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default)
    }
}

// 摆动动画
struct SwingModifier: ViewModifier {
    @Binding var swing: Bool
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle.degrees(swing ? 10 : -10))
            .animation(swing ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default)
    }
}

// 旋转动画
struct RotateModifier: ViewModifier {
    @Binding var rotate: Bool
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle.degrees(rotate ? 360 : 0))
            .animation(rotate ? Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default)
    }
}

public extension View {
    // 旋转动画
    func rotateAnimation2(_ rotate: Bool) -> some View {
        self.modifier(RotateModifier2(rotate: rotate))
    }
}
// 旋转动画
struct RotateModifier2: ViewModifier {
    @State var rotate: Bool
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle.degrees(rotate ? 360 : 0))
            .animation(rotate ? Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default)
    }
}

// 木鱼动画
struct BreatheModifier: ViewModifier {
    @Binding var breathe: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(breathe ? 1.2 : 1.0)
            .animation(breathe ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default)
    }
}


// 木鱼动画
struct WoodenFishModifier: ViewModifier {
    @Binding var knockModel: AnimationModel
    
    func body(content: Content) -> some View {
        content
//            .scaleEffect(knock ? 1.2 : 1.0)
//            .animation(knock ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default)
//            .scaleEffect(knockModel.isAnimating ? knockModel.animatingScale : 1.0, anchor: .center)  // 设置缩放比例
            .animation(.easeInOut(duration: knockModel.duration), value: knockModel.isAnimating)  // 动画时长
    }
}

// 脉冲动画
struct PulseModifier: ViewModifier {
    @Binding var pulse: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(pulse ? 1.2 : 1.0)
            .opacity(pulse ? 0.5 : 1.0)
            .animation(pulse ? Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default)
    }
}
