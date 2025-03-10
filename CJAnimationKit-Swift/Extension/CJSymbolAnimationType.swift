//
//  CJEasyAnimationExtension.swift
//  CJAnimationKitDemo
//
//  Created by qian on 2024/12/15.
//

import SwiftUI

// 定义一个 SymbolEffect 枚举，模拟系统提供的效果
public enum SymbolEffectType: String, Sendable, CaseIterable, Codable {
    // 无
    case none
    // 弹跳
    case bounceUp    // 弹跳 向上
    case bounceDown  // 弹跳 向下
    // 缩放
    case scaleUp     // 缩放 向上
    case scaleDown   // 缩放 向下
    // 摇摆
    case wiggleForward           // 摇摆 小范围 向前
    case wiggleBackward          // 摇摆 小范围 向后
    case wiggleUp                // 摇摆 固定 向上
    case wiggleDown              // 摇摆 固定 向下
    case wiggleLeft              // 摇摆 固定 向左
    case wiggleRight             // 摇摆 固定 向右
    case wiggleClockwise         // 摇摆 固定 顺时针
    case wiggleCounterClockwise  // 摇摆 固定 逆时针
    case wiggleCustom40          // 摇摆 固定 自定义角度
    // 旋转
    case rotateClockwise         // 旋转 顺时针
    case rotateCounterClockwise  // 旋转 逆时针
    // 呼吸
    case breathePlain            // 呼吸 普通
    case breathePulse            // 呼吸 跳动
    // 跳动 = 脉冲
    case pulse                          // 跳动 = 脉冲
    
    public var description: String {
        switch self {
        case .none:
            return "无动画"
        case .bounceUp:
            return "弹跳"
        case .bounceDown:
            return "弹跳向下"
        case .scaleUp:
            return "缩放"
        case .scaleDown:
            return "缩放向下"
        case .wiggleForward:
            return "摇摆"
        case .wiggleBackward:
            return "摇摆向后"
        case .wiggleUp:
            return "摇摆"
        case .wiggleDown:
            return "摇摆向下"
        case .wiggleLeft:
            return "摇摆向左"
        case .wiggleRight:
            return "摇摆向右"
        case .wiggleClockwise:
            return "抖动" //"摇摆顺时针"
        case .wiggleCounterClockwise:
            return "摇摆逆时针"
        case .wiggleCustom40:
            return "摇摆自定义角度"
        case .rotateClockwise:
            return "旋转"
        case .rotateCounterClockwise:
            return "旋转逆时针"
        case .breathePlain:
            return "呼吸"
        case .breathePulse:
            return "呼吸" //"呼吸跳动"
        case .pulse:
            return "脉冲"
        }
    }
    
    // 将字符串映射到对应的 SymbolEffect 枚举
    static func fromString(_ effect: String) -> SymbolEffectType {
        switch effect.lowercased() {
        case "bounce":
            return .bounceUp
        case "bounce.down":
            return .bounceDown
        case "scale":
            return .scaleUp
        case "scale.down":
            return .scaleDown
        case "wiggle":
            return .wiggleForward
        case "shake":
            return .wiggleClockwise
        case "rotate":
            return .rotateClockwise
        case "breathe":
            return .breathePulse
        case "pulse":
            return .pulse
        default:
            return .none
        }
    }
    
    @available(iOS 18.0, *)
    public func apply(to symbol: Image) -> some View {
        switch self {
        // 弹跳
        case .bounceUp:
            return AnyView(
                symbol
                    .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
            )
        case .bounceDown:
            return AnyView(
                symbol
                    .symbolEffect(.bounce.down.byLayer, options: .repeat(.continuous))
            )
        // 缩放
        case .scaleUp:
            return AnyView(
                symbol
                    .symbolEffect(.scale.up.byLayer, options: .repeat(.continuous))
            )
        case .scaleDown:
            return AnyView(
                symbol
                    .symbolEffect(.scale.down.byLayer, options: .repeat(.continuous))
            )
        // 摇摆
        case .wiggleForward:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.forward.byLayer, options: .repeat(.continuous))
            )
        case .wiggleBackward:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.backward.byLayer, options: .repeat(.continuous))
            )
        case .wiggleUp:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
            )
        case .wiggleDown:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.down.byLayer, options: .repeat(.continuous))
            )
        case .wiggleLeft:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.left.byLayer, options: .repeat(.continuous))
            )
        case .wiggleRight:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.right.byLayer, options: .repeat(.continuous))
            )
        case .wiggleClockwise:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.clockwise.byLayer, options: .repeat(.continuous))
            )
        case .wiggleCounterClockwise:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.counterClockwise.byLayer, options: .repeat(.continuous))
            )
        case .wiggleCustom40:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.custom(angle: 40.0).byLayer, options: .repeat(.continuous))
            )
        // 旋转
        case .rotateClockwise:
            return AnyView(
                symbol
                    .symbolEffect(.rotate.clockwise.byLayer, options: .repeat(.continuous))
            )
        case .rotateCounterClockwise:
            return AnyView(
                symbol
                    .symbolEffect(.rotate.counterClockwise.byLayer, options: .repeat(.continuous))
            )
        // 呼吸
        case .breathePlain:
            return AnyView(
                symbol
                    .symbolEffect(.breathe.plain.byLayer, options: .repeat(.continuous))
            )
        case .breathePulse:
            return AnyView(
                symbol
                    .symbolEffect(.breathe.pulse.byLayer, options: .repeat(.continuous))
            )
        // 跳动 = 脉冲
        case .pulse:
            return AnyView(
                symbol
                    .symbolEffect(.pulse)
            )
        default:
            return AnyView(
                symbol
            )
        }
    }
}

public extension Image {
    @available(iOS 18.0, *)
    func applyEffect(_ effect: SymbolEffectType) -> some View {
        return effect.apply(to: self)
    }
}
