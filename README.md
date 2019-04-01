# ColourWheel

[![CI Status](https://img.shields.io/travis/jdstmporter/ColourWheel.svg?style=flat)](https://travis-ci.org/jdstmporter/ColourWheel)
[![Version](https://img.shields.io/cocoapods/v/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![License](https://img.shields.io/cocoapods/l/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![Platform](https://img.shields.io/cocoapods/p/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)

## API

ColourWheel defines a simple UIKit control that provides interactive colour-picker capability.  It is designable, so it works naturally with XCode's Interface Designer.  
It is implemented as a single class: `ColourWheelControl`, which inherits from `UIControl` and so exhibits all the usual configuration properties (e.g. background colour, border, `UIEvent`, etc).

Specific aspects of the API for `ColourWheelControl` that are of importance are as follows:

*  Reading  `var colour : UIColor` gives the currently selected colour, writing to it resets the control to point at the specified colour; this property is exposed to Interface Builder
*  The control fires the event  `UIEvent.valueChanged` whenever the selected colour changes; events are managed in the usual manner for `UIControl` instances
*  `var nBits : UInt` defines number of bits used to represent colour components (so `nBits = 3` would give 3 bits per colour component, i.e. 8 levels for each of RGB or HSV).  This can be useful if you want to restrict the palette available to users.  It can be configured in Interface Builder.  The default is `nBits = 8` (standard 24 bit colour HSV). 

Everything else, including layout, is managed by the control.  



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.  The demo has `nBits=3`, but this can be configured:

#### nBits = 3

![A Screenshot with 3 bits per component](https://github.com/jdstmporter/ColourWheel/blob/master/Extras/ColourWheel-3bits-screenshot.png)

#### nBits = 8

![A Screenshot](https://github.com/jdstmporter/ColourWheel/blob/master/Extras/ColourWheel-small-screenshot.png)

## Requirements

## Installation

ColourWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ColourWheel'
```

## Author

jdstmporter, julian@porternet.org.uk.  

## Acknowledgements

This is essentially an extended fork of the Objective-C control written  by [Justin Meiners](https://github.com/justinmeiners/ios-color-wheel).  New features include:

* Port to Swift and modernisation for Swift 4.2 on iOS 11.0 and later
* Addition of custom brightness picker slider, of similar style to the colour wheel, in place of the original `UISlider`
* Quantisation capability
* Improved 'cursor' objects to show the mouse location on the pickers
* `ColourWheelControl` provides the colour wheel, brightness slider and colour well as a single `@IBDesignable` control that can be dropped onto a view in Interface Builder and left to manage itself



## License

ColourWheel is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.
