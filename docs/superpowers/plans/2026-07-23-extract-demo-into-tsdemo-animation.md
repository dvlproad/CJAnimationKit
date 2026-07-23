# Extract Demo Code into TSDemo_Animation & TSDemo_Animation-Swift

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Extract demo code from `CJAnimationKitDemo/` into two separate pod modules (`TSDemo_Animation` for ObjC, `TSDemo_Animation-Swift` for Swift), following the pattern from `001-UIKit-CQDemo-iOS`.

**Architecture:** Two new pod directories at the project root, each with its own podspec. The app shell (`AppDelegate`, `main.m`, `TSAnmaionMainViewController`, `UIWindow+RootSetting`) stays in `CJAnimationKitDemo/` and consumes both pods via local path.

**Tech Stack:** CocoaPods, Objective-C, Swift, Xcode project

---

## File Structure After Extraction

```
CJAnimationKit/
├── TSDemo_Animation/                    # NEW - ObjC demo pod
│   ├── Demos/
│   │   ├── DemosBaseAnimation/          (moved from CJAnimationKitDemo)
│   │   ├── DemosCALayer/                (moved)
│   │   ├── DemosCycle/                  (moved)
│   │   ├── DemosPopup/                  (moved)
│   │   └── DemosRefresh/               (moved)
│   ├── Views/                           (moved)
│   └── Resources/                       (moved)
├── TSDemo_Animation.podspec             # NEW
├── TSDemo_Animation-Swift/              # NEW - Swift demo pod
│   └── DemosEasyAnimation/              (moved from CJAnimationKitDemo)
├── TSDemo_Animation-Swift.podspec       # NEW
├── CJAnimationKitDemo/                  # MODIFIED - app shell only
│   ├── CJAnimationKitDemo/
│   │   ├── AppDelegate.h/m              (kept)
│   │   ├── main.m                       (kept)
│   │   ├── TSAnmaionMainViewController.h/m  (kept)
│   │   ├── UIWindow+RootSetting.h/m     (kept)
│   │   ├── CJAnimationKitDemo-Bridging-Header.h  (kept)
│   │   ├── ViewController.h/m           (kept - unused but harmless)
│   │   ├── Assets.xcassets/             (kept)
│   │   ├── Base.lproj/                  (kept)
│   │   └── Info.plist                   (kept)
│   ├── Podfile                          (MODIFIED)
│   └── ...                              (xcodeproj, xcworkspace, Pods/)
├── CJAnimationKit/                      (unchanged - library)
├── CJAnimationKit-Swift/                (unchanged - library)
└── ...
```

---

## Task 1: Create TSDemo_Animation/ directory and move ObjC demo files

**Files:**
- Create: `TSDemo_Animation/` (entire directory)
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosBaseAnimation/` → `TSDemo_Animation/Demos/DemosBaseAnimation/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosCALayer/` → `TSDemo_Animation/Demos/DemosCALayer/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosCycle/` → `TSDemo_Animation/Demos/DemosCycle/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosPopup/` → `TSDemo_Animation/Demos/DemosPopup/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosRefresh/` → `TSDemo_Animation/Demos/DemosRefresh/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Views/` → `TSDemo_Animation/Views/`
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Resources/` → `TSDemo_Animation/Resources/`

- [ ] **Step 1: Create directory structure**

```bash
mkdir -p TSDemo_Animation/Demos
```

- [ ] **Step 2: Move Demo subdirectories (ObjC only)**

```bash
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosBaseAnimation TSDemo_Animation/Demos/
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosCALayer TSDemo_Animation/Demos/
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosCycle TSDemo_Animation/Demos/
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosPopup TSDemo_Animation/Demos/
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosRefresh TSDemo_Animation/Demos/
```

- [ ] **Step 3: Move Views/ and Resources/**

```bash
mv CJAnimationKitDemo/CJAnimationKitDemo/Views TSDemo_Animation/
mv CJAnimationKitDemo/CJAnimationKitDemo/Resources TSDemo_Animation/
```

- [ ] **Step 4: Remove empty Demos directory if只剩 DemosEasyAnimation**

```bash
# DemosEasyAnimation will be moved in Task 2, so remove the Demos dir after
rmdir CJAnimationKitDemo/CJAnimationKitDemo/Demos 2>/dev/null || true
```

- [ ] **Step 5: Verify moved files**

```bash
find TSDemo_Animation -type f | head -30
```

---

## Task 2: Create TSDemo_Animation-Swift/ directory and move Swift demo files

**Files:**
- Create: `TSDemo_Animation-Swift/` (entire directory)
- Move: `CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosEasyAnimation/` → `TSDemo_Animation-Swift/DemosEasyAnimation/`

- [ ] **Step 1: Create directory and move Swift demo**

```bash
mkdir -p TSDemo_Animation-Swift
mv CJAnimationKitDemo/CJAnimationKitDemo/Demos/DemosEasyAnimation TSDemo_Animation-Swift/
```

- [ ] **Step 2: Clean up empty Demos directory**

```bash
rmdir CJAnimationKitDemo/CJAnimationKitDemo/Demos 2>/dev/null || true
```

- [ ] **Step 3: Verify**

```bash
find TSDemo_Animation-Swift -type f
```

Expected:
```
TSDemo_Animation-Swift/DemosEasyAnimation/TSEasyAnimationHomeViewController.swift
TSDemo_Animation-Swift/DemosEasyAnimation/EasyAnimationViewDemo/TSEasyAnimationViewController.swift
TSDemo_Animation-Swift/DemosEasyAnimation/EasyAnimationViewDemo/TSEasyAnimationView.swift
```

---

## Task 3: Create TSDemo_Animation.podspec

**Files:**
- Create: `TSDemo_Animation.podspec`

- [ ] **Step 1: Write the podspec**

```ruby
Pod::Spec.new do |s|
  s.name         = "TSDemo_Animation"
  s.version      = "0.0.1"
  s.summary      = "CJAnimationKit 演示示例"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.license      = "MIT"
  s.author       = { "dvlproad" => "" }

  s.platform     = :ios, "14.0"
  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "TSDemo_Animation_0.0.1" }

  s.frameworks   = "UIKit"
  s.requires_arc = true

  s.source_files = "TSDemo_Animation/**/*.{h,m}"
  s.resources    = "TSDemo_Animation/**/*.{xib,xcassets,png,jpg}"

  s.dependency "CQDemoKit"
  s.dependency "CQDemoResource"
  s.dependency "CJAnimationKit"
  s.dependency "Shimmer"
end
```

- [ ] **Step 2: Verify podspec syntax**

```bash
pod lib lint TSDemo_Animation.podspec --no-clean --allow-warnings 2>&1 | tail -5
```

---

## Task 4: Create TSDemo_Animation-Swift.podspec

**Files:**
- Create: `TSDemo_Animation-Swift.podspec`

- [ ] **Step 1: Write the podspec**

```ruby
Pod::Spec.new do |s|
  s.name         = "TSDemo_Animation-Swift"
  s.version      = "0.0.1"
  s.summary      = "TSDemo_Animation Swift 版 - 补充使用 Swift 语言实现的动画演示界面"
  s.homepage     = "https://github.com/dvlproad/CJAnimationKit"

  s.license      = "MIT"
  s.author       = { "dvlproad" => "" }

  s.platform     = :ios, "14.0"
  s.source       = { :git => "https://github.com/dvlproad/CJAnimationKit.git", :tag => "TSDemo_Animation-Swift_0.0.1" }
  s.swift_version = "5.0"

  s.frameworks   = "UIKit", "SwiftUI"
  s.requires_arc = true

  s.source_files = "TSDemo_Animation-Swift/**/*.{swift}"

  s.dependency "TSDemo_Animation"
end
```

- [ ] **Step 2: Verify podspec syntax**

```bash
pod lib lint TSDemo_Animation-Swift.podspec --no-clean --allow-warnings 2>&1 | tail -5
```

---

## Task 5: Update Podfile to consume new pods

**Files:**
- Modify: `CJAnimationKitDemo/Podfile`

- [ ] **Step 1: Add TSDemo_Animation and TSDemo_Animation-Swift to Podfile**

Replace the target block in `CJAnimationKitDemo/Podfile`:

```ruby
target 'CJAnimationKitDemo' do
  pod 'CQDemoKit',              '~> 0.9.10',    :subspecs => ['BaseVC', 'BaseUIKit', 'BaseUtil', 'Demo_RipeView', 'Demo_Resource']
  pod 'CQDemoResource',         '~> 0.3.0',     :subspecs => ['Images']
  pod 'CJBaseUIKit',            '~> 0.8.1',     :subspecs => ['UIView/CJDragAction', 'UINavigationBar']

  pod 'HWWeakTimer', '~> 1.0'

  pod 'CJAnimationKit',         path: '../'
  pod 'CJAnimationKit-Swift',   path: '../'

  pod 'TSDemo_Animation',       path: '../'
  pod 'TSDemo_Animation-Swift', path: '../'
end
```

Note: Removed `pod 'Shimmer'` since it's now a dependency of `TSDemo_Animation`.

- [ ] **Step 2: Run pod install**

```bash
cd CJAnimationKitDemo && pod install
```

---

## Task 6: Update Xcode project references

**Files:**
- Modify: `CJAnimationKitDemo/CJAnimationKitDemo.xcodeproj/project.pbxproj`

After moving files, the Xcode project will have broken references. We need to:

1. Remove references to moved files from the Xcode project
2. The new pods will be auto-linked via CocoaPods

- [ ] **Step 1: Open Xcode and let it auto-resolve missing references**

The easiest approach is to open `CJAnimationKitDemo.xcworkspace` in Xcode. Xcode will show red (missing) file references. Select them and delete (move to trash).

Alternatively, manually edit `project.pbxproj` to remove references to:
- `Demos/` directory and all its children
- `Views/` directory and all its children
- `Resources/` directory and all its children

- [ ] **Step 2: Verify build**

```bash
cd CJAnimationKitDemo && xcodebuild build -workspace CJAnimationKitDemo.xcworkspace -scheme CJAnimationKitDemo -destination 'platform=iOS Simulator,name=iPhone 15' CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO 2>&1 | tail -20
```

---

## Task 7: Verify the app still works

- [ ] **Step 1: Check that all demo VCs are accessible**

The tab bar in `TSAnmaionMainViewController` references:
- `BaseAnimationViewController` (from TSDemo_Animation)
- `QuartzCoreHomeViewController` (from TSDemo_Animation)
- `CycleHomeViewController` (from TSDemo_Animation)
- `PopupHomeViewController` (from TSDemo_Animation)
- `RefreshHomeViewController` (from TSDemo_Animation)

Verify imports work by checking that the auto-generated `TSDemo_Animation-umbrella.h` includes these headers.

- [ ] **Step 2: Update import statements if needed**

If `TSAnmaionMainViewController.m` imports use `#import "XXX.h"`, they should still work since CocoaPods adds the pod's source files to the build. No import changes needed.

- [ ] **Step 3: Verify Swift demo is accessible**

`TSEasyAnimationHomeViewController.swift` is currently all commented out. The Swift demo pod (`TSDemo_Animation-Swift`) depends on `TSDemo_Animation` (ObjC), so Swift code can reference ObjC classes if needed.

---

## Notes

- `TSAnmaionMainViewController.m` has `#import "CJAnimationKitDemo-Swift.h"` which references Swift classes from the app target. Since the Swift demo files are now in a separate pod, this import may need to be removed or replaced with `#import <TSDemo_Animation-Swift/TSDemo_Animation-Swift-Swift.h>` if any Swift classes are used. Currently, the import appears unused in the active code (no Swift classes are referenced in the tab setup).
- `AppDelegate.m` imports `"UIWindow+RootSetting.h"` which stays in the app target, so no change needed.
- The `CJAnimationKitDemo-Bridging-Header.h` stays in the app target for Swift/ObjC interop.
