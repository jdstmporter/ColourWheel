# ColourWheel

[![CI Status](https://img.shields.io/travis/jdstmporter/ColourWheel.svg?style=flat)](https://travis-ci.org/jdstmporter/ColourWheel)
[![Version](https://img.shields.io/cocoapods/v/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![License](https://img.shields.io/cocoapods/l/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)
[![Platform](https://img.shields.io/cocoapods/p/ColourWheel.svg?style=flat)](https://cocoapods.org/pods/ColourWheel)

`ColourWheelControl` defines a simple UIKit control that provides interactive colour-picker capability.  The class is `@IBDesignable`, so it works naturally with XCode's Interface Designer.  It inherits from `UIControl` and so exhibits all the usual configuration properties (e.g. background colour, border, `UIEvent`, etc) and functions, e.g. it manages its own layout.

## API

### Initialisers
Initialisers are inherited from `UIControl`

### @IBInspectable properties

-  `brightnessEnabled : Bool { get set }` 
   
   Whether or nor the optional brigtness-chooser strip is visible / active in the control.  When it is set to `false`, all colours have a default brightness of *1.0*.
   
   **Warning**: This parameter should be set once and for all when the control is instantiated; changing it dynamically may have unforseen side-effects.
   
   default = *true* (brightness selector enabled)
   
- `nBits : UInt { get set }`
   
   The number of bits used to represent colour components (so setting it to 3  would give 3 bits per colour 
   component, i.e. 8 levels for each of RGB or HSV).  This can be useful if you want to restrict the palette 
   available to users.
   
   default = 8 (standard 24 bit colour HSV)
   
- `colour : UIColor { get set }`
   
   The currently selected colour.  Writing to it resets the control to point at the specified colour.
  
### Events

The standard  `UIEvent.valueChanged` is fired whenever the selected colour changes.
 
Events are managed in the usual manner for UIControl instances, nd so the control can be wired up in 
Interface Builder like any other control.

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

* Port to Swift and modernisation for Swift 5 on iOS 12.0 and later
* Addition of custom brightness picker slider, of similar style to the colour wheel, in place of the original `UISlider`
* Quantisation capability
* Improved 'cursor' objects to show the mouse location on the pickers
* `ColourWheelControl` provides the colour wheel, brightness slider and colour well as a single `@IBDesignable` control that can be dropped onto a view in Interface Builder and left to manage itself

Also, many thanks to [ConfusedVorlon](https://github.com/ConfusedVorlon) for bringing to my attention conditions under which a control built its colour wheel multiple times, 
causing performance degradation, and subsequent help diagnosing the problem and testing fixes.
This contributed to the changes made in version 0.5.0.

## License

ColourWheel is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.


## Version history

<table>
<tr>
<td><b>0.6.0</b</td>
<td>
Made brightness selector control optional, selected by property setting
</td>
<tr>
<td><b>0.5.1</b></td>
<td>
Extended documentation
</td>
</tr>
<tr>
<td><b>0.5.0</b></td>
<td>
Upgrade to baseline support for Swift 5, iOS 12<br/> 
Added check to avoid redundant computation of wheel graphic
</td>
</tr>
<tr>
<td><b>0.4.1</b></td>
<td>
Updated documentation
</td>
</tr>
<tr>
<td><b>0.4.0</b></td>
<td>
Introduced capability to quantise colours on the wheel, 
so making a restricted palette available
</td>
</tr>
<tr>
<td><b>0.3.0</b></td>
<td>
Improved pod packaging
</td>
</tr>
<tr>
<tr>
<td><b>0.2.0</b></td>
<td>
Compatibility with Swift 5 and iOS 12
</td>
</tr>
<tr>
<td><b>0.1.0</b></td>
<td>
Initial version, with baseline support for Swift 4 and iOS 11
</td>
</tr>
</table>






