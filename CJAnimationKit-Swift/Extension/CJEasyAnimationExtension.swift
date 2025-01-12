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
    
    func cjAnimation(type: Binding<AnimationType>) -> some View {
        let animationType = type.wrappedValue    // 通过 wrappedValue 属性来获取其绑定的值
        return self
            .bounceAnimation(animationType == .bounce)
            .swingAnimation(animationType == .swing)
            .rotateAnimation(animationType == .rotate)
            //.woodenFishAnimation(animationType == .woodenFish)
            .breatheAnimation(animationType == .breathe)
            .pulseAnimation(animationType == .pulse)
    }
    
    /*
    // 弹跳动画
    func cjAnimation(type: AnimationType, isAnimating: Bool) -> some View {
        var view: any View
        if type == .bounce {
            view = self.bounceAnimation(.constant(isAnimating))
        } else if type == .swing {
            view = self.swingAnimation(.constant(isAnimating))
        } else if type == .rotate {
            view = self.rotateAnimation(.constant(isAnimating))
//        } else if type == .woodenFish {
//            return self.woodenFishAnimation(.constant(isAnimating))
        } else if type == .breathe {
            view = self.breatheAnimation(.constant(isAnimating))
        } else if type == .pulse {
            view = self.pulseAnimation(.constant(isAnimating))
        } else {
            view = self
        }
        
        return AnyView(view)
    }
    
    
    func cjAnimation(type: Binding<AnimationType>, isAnimating: Binding<Bool>) -> some View {
        var view: any View
        let type = type.wrappedValue    // 通过 wrappedValue 属性来获取其绑定的值
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
    */
}

public extension View {
    
    
    // 弹跳动画
    func bounceAnimation(_ isAnimating: Bool) -> some View {
        self.modifier(BounceModifier(bounce: .constant(isAnimating)))
    }
    func bounceAnimation(_ isAnimating: Binding<Bool>) -> some View {
        self.modifier(BounceModifier(bounce: isAnimating))
    }
    
    // 摆动动画
    func swingAnimation(_ swing: Bool) -> some View {
        self.modifier(SwingModifier(swing: .constant(swing)))
    }
    func swingAnimation(_ swing: Binding<Bool>) -> some View {
        self.modifier(SwingModifier(swing: swing))
    }
    
    // 旋转动画
    func rotateAnimation(_ rotate: Bool) -> some View {
        self.modifier(RotateModifier(rotate: .constant(rotate)))
    }
    func rotateAnimation(_ rotate: Binding<Bool>) -> some View {
        self.modifier(RotateModifier(rotate: rotate))
    }
    
    // 木鱼动画
    func woodenFishAnimation(_ knockModel: AnimationModel) -> some View {
        self.modifier(WoodenFishModifier(knockModel: .constant(knockModel)))
    }
    func woodenFishAnimation(_ knockModel: Binding<AnimationModel>) -> some View {
        self.modifier(WoodenFishModifier(knockModel: knockModel))
    }
    
    // 呼吸动画
    func breatheAnimation(_ breathe: Bool) -> some View {
        self.modifier(BreatheModifier(breathe: .constant(breathe)))
    }
    func breatheAnimation(_ breathe: Binding<Bool>) -> some View {
        self.modifier(BreatheModifier(breathe: breathe))
    }
    
    // 脉冲动画
    func pulseAnimation(_ pulse: Bool) -> some View {
        self.modifier(PulseModifier(pulse: .constant(pulse)))
    }
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
            .animation(bounce ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default,
                       value: bounce)
    }
//    
//    @State private var offset: CGFloat = 0 // 动态控制偏移量
//
//        func body(content: Content) -> some View {
//            content
//                .offset(y: offset)
//                .animation(bounce ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default, value: offset)
////                .onAppear {
////                    startBounceIfNeeded()
////                }
//                .onChange(of: bounce) { newValue in
//                    if newValue {
//                        startBounceIfNeeded()
//                    } else {
//                        stopBounce()
//                    }
//                }
//        }
//
//        private func startBounceIfNeeded() {
////            guard bounce else { return }
//            // 设置偏移量触发动画
//            offset = -20
//        }
//
//        private func stopBounce() {
//            // 恢复偏移量，停止动画
//            offset = 0
//        }
}

// 摆动动画
struct SwingModifier: ViewModifier {
    @Binding var swing: Bool
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle.degrees(swing ? 10 : 0))
            .animation(swing ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default,
                       value: swing)
    }
}

// 旋转动画
struct RotateModifier: ViewModifier {
    @Binding var rotate: Bool
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle.degrees(rotate ? 360 : 0))
            .animation(rotate ? Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default,
                       value: rotate)
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
            .animation(rotate ? Animation.linear(duration: 2).repeatForever(autoreverses: false) : .default,
                       value: rotate)
    }
}

// 木鱼动画
struct BreatheModifier: ViewModifier {
    @Binding var breathe: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(breathe ? 1.2 : 1.0)
            .animation(breathe ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default,
                       value: breathe)
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
            .animation(pulse ? Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true) : .default,
                       value: pulse)
    }
}
