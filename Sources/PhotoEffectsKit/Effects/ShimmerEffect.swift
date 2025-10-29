//
//  ShimmerEffect.swift
//  PhotoEffectsKit
//
//  可复用的闪光高亮效果
//

import SwiftUI

/// Shimmer 配置
public struct ShimmerConfig {
    public var tint: Color
    public var highlight: Color
    public var blur: CGFloat
    public var highlightOpacity: CGFloat
    public var speed: CGFloat
    public var blendMode: BlendMode
    
    public init(
        tint: Color,
        highlight: Color,
        blur: CGFloat = 0,
        highlightOpacity: CGFloat = 1,
        speed: CGFloat = 2,
        blendMode: BlendMode = .normal
    ) {
        self.tint = tint
        self.highlight = highlight
        self.blur = blur
        self.highlightOpacity = highlightOpacity
        self.speed = speed
        self.blendMode = blendMode
    }
}

/// Shimmer Effect Custom View Modifier
extension View {
    /// 添加 Shimmer 闪光效果
    /// - Parameter config: Shimmer 配置
    /// - Returns: 应用了 Shimmer 效果的视图
    @ViewBuilder
    public func shimmer(_ config: ShimmerConfig) -> some View {
        self.modifier(ShimmerEffectHelper(config: config))
    }
}

/// Shimmer Effect Helper
fileprivate struct ShimmerEffectHelper: ViewModifier {
    var config: ShimmerConfig
    @State private var moveTo: CGFloat = -0.7
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        GeometryReader {
                            let size = $0.size
                            let extraOffset = (size.height / 2.5) + config.blur
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                        .fill(
                                            .linearGradient(colors: [
                                                .white.opacity(0),
                                                config.highlight.opacity(config.highlightOpacity),
                                                .white.opacity(0)
                                            ], startPoint: .top, endPoint: .bottom)
                                        )
                                        .blur(radius: config.blur)
                                        .rotationEffect(.init(degrees: -70))
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                                .blendMode(config.blendMode)
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}

/// 条件 Shimmer - 仅在启用时应用
public struct ConditionalShimmer: ViewModifier {
    public var enabled: Bool
    public var config: ShimmerConfig
    
    public init(enabled: Bool, config: ShimmerConfig) {
        self.enabled = enabled
        self.config = config
    }
    
    public func body(content: Content) -> some View {
        if enabled {
            content.shimmer(config)
        } else {
            content
        }
    }
}
