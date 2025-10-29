# PhotoEffectsKit

一个可复用的 SwiftUI 照片特效库,包含高质量的视觉效果和 UI 组件。

## ✨ 特性

### 视觉效果
- **ShimmerEffect** - 流动闪光高亮效果
- **DisintegrationEffect** - "灰飞烟灭"粒子消散动画

### UI 组件  
- **CropOverlay** - 可拖拽的裁剪框组件

### 工具扩展
- **View+Snapshot** - 视图快照生成工具

## 📦 安装

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/PhotoEffectsKit.git", from: "1.0.0")
]
```

## 🚀 使用示例

### Shimmer 效果

```swift
import SwiftUI
import PhotoEffectsKit

struct ContentView: View {
    var body: some View {
        Text("Hello World!")
            .shimmer(ShimmerConfig(
                tint: .white.opacity(0.5),
                highlight: .white,
                blur: 5,
                speed: 2
            ))
    }
}
```

### Disintegration 效果

```swift
import SwiftUI
import PhotoEffectsKit

struct ContentView: View {
    @State private var isDeleted = false
    
    var body: some View {
        Image(systemName: "star.fill")
            .font(.system(size: 100))
            .disintegrationEffect(isDeleted: isDeleted) {
                print("动画完成!")
            }
            .onTapGesture {
                isDeleted = true
            }
    }
}
```

### 裁剪框

```swift
import SwiftUI
import PhotoEffectsKit

struct ContentView: View {
    @State private var cropRect = CGRect(x: 50, y: 100, width: 300, height: 300)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("myPhoto")
                    .resizable()
                    .scaledToFit()
                
                CropOverlay(
                    cropRect: $cropRect,
                    containerSize: geometry.size,
                    imageSize: CGSize(width: 1000, height: 1000)
                )
            }
        }
    }
}
```

## 📋 要求

- iOS 16.0+
- Swift 5.9+
- Xcode 15.0+

## 📝 License

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request!

## ✅ 独立性

所有组件完全独立,无外部依赖:
- ✅ 无 SwiftData 依赖
- ✅ 无 Photos 框架依赖  
- ✅ 纯 SwiftUI 实现
- ✅ 可直接在任何项目中使用
