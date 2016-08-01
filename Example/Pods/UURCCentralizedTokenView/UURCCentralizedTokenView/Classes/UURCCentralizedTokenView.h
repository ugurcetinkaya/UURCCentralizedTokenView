//
//  UURCCentralizedTokenView.h
//  ceuur
//
//  Created by Ugur Cetinkaya on 03/02/16.
//  Copyright © 2016 Ugur Cetinkaya All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UURCCentralizedTokenViewDelegate <NSObject>

- (void)actionToken:(NSNumber *)tokenIndex;

@end

@interface UURCCentralizedTokenView : UIView

@property (weak) UIViewController *parentViewController;

- (instancetype)initWithTokenArray:(NSArray *)tokenArray;

//token style for unselected
@property (nonatomic, strong) UIColor *unselectedTokenColor;
@property (nonatomic, strong) UIColor *unselectedTokenBorderColor;
@property (nonatomic, strong) UIColor *unselectedTokenTitleColor;
@property (nonatomic, strong) UIFont *unselectedTokenFont;
@property (nonatomic, assign) CGFloat unselectedTokenRadius;

//token style for selected
@property (nonatomic, strong) UIColor *selectedTokenColor;
@property (nonatomic, strong) UIColor *selectedTokenBorderColor;
@property (nonatomic, strong) UIColor *selectedTokenTitleColor;
@property (nonatomic, strong) UIFont *selectedTokenFont;
@property (nonatomic, assign) CGFloat selectedTokenRadius;

@property (nonatomic, assign) CGFloat tokenViewLeftPadding;
@property (nonatomic, assign) CGFloat tokenViewRightPadding;
@property (nonatomic, assign) CGFloat tokenPadding;
@property (nonatomic, assign) UIEdgeInsets tokenEdgeInsets;

- (void)reloadTokens;
- (void)removeTokens;
- (void)setTokenSelected:(NSNumber *)tokenIndex;

@end
