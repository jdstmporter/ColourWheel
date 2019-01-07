# ColourWheel

[![CI Status](https://img.shields.io/travis/jdstmporter/ColourWheel.svg?style=flat)](https://travis-ci.org/jdstmporter/ColourWheel)
[![Version](https://img.shields.io/cocoapods/v/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![License](https://img.shields.io/cocoapods/l/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![Platform](https://img.shields.io/cocoapods/p/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)

## API

ColourWheel defines a simple UIKit control that provides interactive colour-picker capability.  It is designable, so it works naturally with XCode's Interface Designer.  It is implemented as a single class: `ColourWheelControl`, which inherits from `UIControl` and so exhibits all the usual configuration variables.

Specific aspects of the API that are of importance:

* The read-only property  `var colour : UIColor { get }` gives the currently selected colour
* The event `UIEvent.valueChanged` is invoked whenever the selected colour changes; it can be connected to via Interface Builder

Apart from that, it manages itself.



## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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

This is essentially an extended fork of the Objective-C version  by [JustinMeiners](https://github.com/justinmeiners/ios-color-wheel).  New features include:

* Port and modrnisation for Swift 4.2 on iOS 11.0 and later
* A custom brightness picker slider, of similar style to the colour wheel
* Improved 'cursor' objects to show th mouse location on controls
* A portmanteau UIControl which provides the colour wheel / brightness slider / colour well as a single @IBDesignable view that can be dropped onto a view in Interface Builder



## License

ColourWheel is available under the MIT license. See the LICENSE file for more info.
