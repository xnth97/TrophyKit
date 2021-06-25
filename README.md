# TrophyKit

An animated trophy banner that looks like Xbox achievement.

[![Version](https://img.shields.io/cocoapods/v/TrophyKit.svg?style=flat)](https://cocoapods.org/pods/TrophyKit)
[![License](https://img.shields.io/cocoapods/l/TrophyKit.svg?style=flat)](https://cocoapods.org/pods/TrophyKit)
[![Platform](https://img.shields.io/cocoapods/p/TrophyKit.svg?style=flat)](https://cocoapods.org/pods/TrophyKit)

## Demo

https://user-images.githubusercontent.com/6781789/123460143-0b87dd80-d59c-11eb-97f9-4951e914a106.mov

## Usage
### Requirements

* iOS 14.0+
* Swift 5.3+

### Installation

TrophyKit is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TrophyKit'
```

### Example

To run the example project, clone the repo, and run pod install from the Example directory first.

### API

```swift
/// Create a trophy instance.
let trophy = Trophy(iconSymbol: "gamecontroller.fill",
                    trophyIconSymbol: "rosette",
                    title: "Achievement Unlocked",
                    subtitle: "You have added a new skill!",
                    size: .medium)

/// Show trophy from view controller.
trophy.show(from: self)
```

## TODO

- [ ] More customization APIs
- [ ] Tweak animation and visual
- [ ] Sound and haptic support
- [ ] Swift Package Manager
- [ ] Queue for multiple trophies
- [ ] Position for display trophy banner
- [ ] Manually hide banner
- [ ] Support anchor view like toolbar or tab bar

## License

TrophyKit is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
