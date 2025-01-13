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
    case bounceUpByLayer    // 弹跳 向上
    case bounceDownByLayer  // 弹跳 向下
    // 缩放
    case scaleUpByLayer     // 缩放 向上
    case scaleDownByLayer   // 缩放 向下
    // 摇摆
    case wiggleForwardByLayer           // 摇摆 小范围 向前
    case wiggleBackwardByLayer          // 摇摆 小范围 向后
    case wiggleUpByLayer                // 摇摆 固定 向上
    case wiggleDownByLayer              // 摇摆 固定 向下
    case wiggleLeftByLayer              // 摇摆 固定 向左
    case wiggleRightByLayer             // 摇摆 固定 向右
    case wiggleClockwiseByLayer         // 摇摆 固定 顺时针
    case wiggleCounterClockwiseByLayer  // 摇摆 固定 逆时针
    case wiggleCustom40ByLayer          // 摇摆 固定 自定义角度
    // 旋转
    case rotateClockwiseByLayer         // 旋转 顺时针
    case rotateCounterClockwiseByLayer  // 旋转 逆时针
    // 呼吸
    case breathePlainByLayer            // 呼吸 普通
    case breathePulseByLayer            // 呼吸 跳动
    // 跳动 = 脉冲
    case pulse                          // 跳动 = 脉冲
    
    public var description: String {
        switch self {
        case .none:
            return "无动画"
        case .bounceUpByLayer:
            return "弹跳"
        case .bounceDownByLayer:
            return "弹跳向下"
        case .scaleUpByLayer:
            return "缩放"
        case .scaleDownByLayer:
            return "缩放向下"
        case .wiggleForwardByLayer:
            return "摇摆"
        case .wiggleBackwardByLayer:
            return "摇摆向后"
        case .wiggleUpByLayer:
            return "摇摆"
        case .wiggleDownByLayer:
            return "摇摆向下"
        case .wiggleLeftByLayer:
            return "摇摆向左"
        case .wiggleRightByLayer:
            return "摇摆向右"
        case .wiggleClockwiseByLayer:
            return "摇摆顺时针"
        case .wiggleCounterClockwiseByLayer:
            return "摇摆逆时针"
        case .wiggleCustom40ByLayer:
            return "摇摆自定义角度"
        case .rotateClockwiseByLayer:
            return "旋转"
        case .rotateCounterClockwiseByLayer:
            return "旋转逆时针"
        case .breathePlainByLayer:
            return "呼吸"
        case .breathePulseByLayer:
            return "呼吸跳动"
        case .pulse:
            return "脉冲"
        }
    }
    
    // 将字符串映射到对应的 SymbolEffect 枚举
    static func fromString(_ effect: String) -> SymbolEffectType {
        switch effect.lowercased() {
        case "bounce":
            return .bounceUpByLayer
        case "bounce.down":
            return .bounceDownByLayer
        case "scale":
            return .scaleUpByLayer
        case "scale.down":
            return .scaleDownByLayer
        case "wiggle":
            return .wiggleForwardByLayer
        case "rotate":
            return .rotateClockwiseByLayer
        case "breathe":
            return .breathePlainByLayer
        case "pulse":
            return .pulse
        default:
            return .none
        }
    }
    
    @available(iOSApplicationExtension 18.0, *)
    public func apply(to symbol: Image) -> some View {
        switch self {
        // 弹跳
        case .bounceUpByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
            )
        case .bounceDownByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.bounce.down.byLayer, options: .repeat(.continuous))
            )
        // 缩放
        case .scaleUpByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.scale.up.byLayer, options: .repeat(.continuous))
            )
        case .scaleDownByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.scale.down.byLayer, options: .repeat(.continuous))
            )
        // 摇摆
        case .wiggleForwardByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.forward.byLayer, options: .repeat(.continuous))
            )
        case .wiggleBackwardByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.backward.byLayer, options: .repeat(.continuous))
            )
        case .wiggleUpByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.up.byLayer, options: .repeat(.continuous))
            )
        case .wiggleDownByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.down.byLayer, options: .repeat(.continuous))
            )
        case .wiggleLeftByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.left.byLayer, options: .repeat(.continuous))
            )
        case .wiggleRightByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.right.byLayer, options: .repeat(.continuous))
            )
        case .wiggleClockwiseByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.clockwise.byLayer, options: .repeat(.continuous))
            )
        case .wiggleCounterClockwiseByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.counterClockwise.byLayer, options: .repeat(.continuous))
            )
        case .wiggleCustom40ByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.wiggle.custom(angle: 40.0).byLayer, options: .repeat(.continuous))
            )
        // 旋转
        case .rotateClockwiseByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.rotate.clockwise.byLayer, options: .repeat(.continuous))
            )
        case .rotateCounterClockwiseByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.rotate.counterClockwise.byLayer, options: .repeat(.continuous))
            )
        // 呼吸
        case .breathePlainByLayer:
            return AnyView(
                symbol
                    .symbolEffect(.breathe.plain.byLayer, options: .repeat(.continuous))
            )
        case .breathePulseByLayer:
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
    @available(iOSApplicationExtension 18.0, *)
    public func applyEffect(_ effect: SymbolEffectType) -> some View {
        return effect.apply(to: self)
    }
}
