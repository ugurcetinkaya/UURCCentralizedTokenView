# UURCCentralizedTokenView

[![CI Status](http://img.shields.io/travis/Ugur Cetinkaya/UURCCentralizedTokenView.svg?style=flat)](https://travis-ci.org/Ugur Cetinkaya/UURCCentralizedTokenView)
[![Version](https://img.shields.io/cocoapods/v/UURCCentralizedTokenView.svg?style=flat)](http://cocoapods.org/pods/UURCCentralizedTokenView)
[![License](https://img.shields.io/cocoapods/l/UURCCentralizedTokenView.svg?style=flat)](http://cocoapods.org/pods/UURCCentralizedTokenView)
[![Platform](https://img.shields.io/cocoapods/p/UURCCentralizedTokenView.svg?style=flat)](http://cocoapods.org/pods/UURCCentralizedTokenView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

# Installation
##Manaully
Add UURCCentralizedTokenView.h and UURCCentralizedTokenView.m files to your project.

##CocoaPods
UURCCentralizedTokenView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UURCCentralizedTokenView'
```

#Usage
Import the UURCCentralizedTokenView library to your ViewController.

```objective-c
#import <UURCCentralizedTokenView/UURCCentralizedTokenView.h>
```

Create an instance UURCCentralizedTokenView class with token array. Then, set style of UURCCentralizedTokenView UI object.

```objective-c
self.tokenView = [[UURCCentralizedTokenView alloc] initWithTokenArray:tokenArray];
self.tokenView.parentViewController = self;
[self.view addSubview:self.tokenView];

// set token view Style
self.tokenView.tokenEdgeInsets = UIEdgeInsetsMake(8, 10, 8, 10);
self.tokenView.unselectedTokenTitleColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
self.tokenView.selectedTokenTitleColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
self.tokenView.selectedTokenColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.67 alpha:1.0];
self.tokenView.selectedTokenBorderColor = [UIColor colorWithRed:1.00 green:0.94 blue:0.67 alpha:1.0];
self.tokenView.unselectedTokenBorderColor = [UIColor colorWithRed:0.72 green:0.11 blue:0.11 alpha:1.0];
```

You can detect selected token with UURCCentralizedTokenViewDelegate delegate method which is actionToken.
```objective-c
- (void)actionToken:(NSNumber *)tokenIndex {
    [self.tokenView setTokenSelected:tokenIndex];
    NSLog(@"%@",tokenIndex);
}
```

## Author

Ugur Cetinkaya, ugurcetinkaya@ymail.com

## License

UURCCentralizedTokenView is available under the MIT license. See the LICENSE file for more info.
