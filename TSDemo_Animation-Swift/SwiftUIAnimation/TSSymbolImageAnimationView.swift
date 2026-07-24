//
//  TSSymbolImageAnimationView.swift
//  CJAnimationKitDemo
//
//  Created by qian on 2025/1/11.
//  Copyright © 2025 dvlproad. All rights reserved.
//

import SwiftUI
import CJAnimationKit_Swift

@available(iOS 18.0, *)
struct TSSymbolImageAnimationView: View {
    @State private var selectedEffect: SymbolEffectType = .none
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 当前选中的效果展示
                VStack {
                    Text("当前效果: \(selectedEffect.description)")
                        .font(.headline)
                    Image(systemName: "heart.fill")
                        .resizable()
                        .applyEffect(selectedEffect)
                        //.symbolEffect(.bounce.up.byLayer, options: .repeat(.continuous))
                        .frame(width: 80, height: 80)
                        .foregroundColor(.red)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                
                // 效果列表
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    ForEach(SymbolEffectType.allCases, id: \.self) { effect in
                        EffectButton(effect: effect, isSelected: selectedEffect == effect) {
                            selectedEffect = effect
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Symbol动画测试")
    }
}

struct EffectButton: View {
    let effect: SymbolEffectType
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: "star.fill")
                    .font(.title2)
                    .foregroundColor(isSelected ? .white : .blue)
                Text(effect.description)
                    .font(.caption)
                    .foregroundColor(isSelected ? .white : .primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .cornerRadius(8)
        }
    }
}

@available(iOS 18.0, *)
struct TSSymbolAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TSSymbolImageAnimationView()
    }
}
